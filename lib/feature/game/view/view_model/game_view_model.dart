import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/game/view/view_model/game_view_model_event.dart';
import 'package:word_game/feature/game/view/view_model/game_view_model_state.dart';
import 'package:word_game/product/service/game_service.dart';
import 'package:word_game/product/state/container/product_state_container.dart';
import 'package:word_game/product/utility/letter_utils.dart';

class GameViewModel extends Bloc<GameEvent, GameViewModelState> {
  final GameService _gameService;
  StreamSubscription? _gameSubscription;

  GameViewModel()
      : _gameService = ProductContainer.read<GameService>(),
        super(GameInitial()) {
    on<CreateRoomEvent>(_onCreateRoom);
    on<JoinRoomEvent>(_onJoinRoom);
    on<StartGameEvent>(_onStartGame);
    on<ListenToGameUpdatesEvent>(_onListenToGameUpdates);
    on<SubmitWordEvent>(_onSubmitWord);
    on<EndGameEvent>(_onEndGame);
    on<CancelRoomEvent>(_onCancelRoom);
    on<LeaveRoomEvent>(_onLeaveRoom);
    on<_UpdateGameStateEvent>(_onUpdateGameState);
  }

  Future<void> _onCreateRoom(CreateRoomEvent event, Emitter<GameViewModelState> emit) async {
    emit(RoomCreating());
    try {
      if (await _gameService.doesRoomExist(event.roomId)) {
        emit(RoomCreationFailed(errorMessage: "Room already exists"));
        return;
      }

      final letters = LetterGenerator.generateRandomLetters(event.letterNumber, event.lang);

      await _gameService.createRoom(
        roomId: event.roomId,
        playerName: event.playerName,
        letters: letters,
        endTime: event.endTime,
        maxPlayers: event.maxPlayers,
        lang: event.lang,
      );

      emit(RoomCreated(roomId: event.roomId, playerName: event.playerName));
      emit(InLobby(players: [event.playerName]));
      add(ListenToGameUpdatesEvent(event.roomId));
    } catch (e) {
      emit(RoomCreationFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _onJoinRoom(JoinRoomEvent event, Emitter<GameViewModelState> emit) async {
    emit(RoomJoining(roomId: event.roomId, playerName: event.playerName));
    try {
      final roomSnapshot = await _gameService.getRoomData(event.roomId);
      if (roomSnapshot == null || !roomSnapshot.exists) {
        throw "Room not found";
      }

      final roomData = roomSnapshot.data()! as Map<String, dynamic>;
      final players = List<String>.from(roomData['players'] ?? []);
      final maxPlayers = roomData['maxPlayers'] as int;

      if (roomData['isStarted'] == true) throw "Game already started";
      if (roomData['isActive'] == false) throw "Room not active";
      if (players.length >= maxPlayers) throw "Room full";
      if (players.contains(event.playerName)) throw "Player already in room";

      players.add(event.playerName);
      await _gameService.updateRoom(event.roomId, {'players': players});

      emit(RoomJoined(roomId: event.roomId, playerName: event.playerName));
      emit(InLobby(players: players));
      add(ListenToGameUpdatesEvent(event.roomId));
    } catch (e) {
      emit(RoomJoinFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _onStartGame(StartGameEvent event, Emitter<GameViewModelState> emit) async {
    try {
      final roomDoc = await _gameService.getRoomData(event.roomId);
      if (roomDoc != null && roomDoc.exists) {
        final roomData = roomDoc.data() as Map<String, dynamic>;
        final playerCount = roomData['players']?.length ?? 0;

        if (playerCount <= 1) {
          final players = List<String>.from(roomData['players'] ?? []);
          emit(InLobby(players: players, errorMessage: "Not enough players"));
          return;
        }

        if (roomData.containsKey('isStarted') && roomData['isStarted'] == true) {
          emit(GameInProgress(roomData));
          return;
        }

        final int gameDuration = roomData['endTime'] ?? 1; // Default to 1 min if missing
        final int computedEndTime = DateTime.now()
            .add(Duration(minutes: gameDuration))
            .millisecondsSinceEpoch;

        await _gameService.updateRoom(event.roomId, {
          'isStarted': true,
          'endTime': computedEndTime,
        });

        final updatedDoc = await _gameService.getRoomData(event.roomId);
        if (updatedDoc != null && updatedDoc.exists) {
          final updatedData = updatedDoc.data() as Map<String, dynamic>;
          emit(GameInProgress(updatedData));
        }
      }
    } catch (e) {
       emit(GameError(e.toString()));
    }
  }

  void _onUpdateGameState(_UpdateGameStateEvent event, Emitter<GameViewModelState> emit) {
    if (!event.snapshot.exists) {
      emit(GameOver([]));
      return;
    }

    final data = event.snapshot.data() as Map<String, dynamic>;

    if (!data['isActive']) {
      emit(GameOver([]));
      return;
    }

    final isStarted = data['isStarted'] ?? false;
    if (isStarted) {
      emit(GameInProgress(data));
    } else {
      final players = List<String>.from(data['players'] ?? []);
      emit(InLobby(players: players));
    }
  }

  Future<void> _onListenToGameUpdates(
      ListenToGameUpdatesEvent event, Emitter<GameViewModelState> emit) async {
    await _gameSubscription?.cancel();

    _gameSubscription = _gameService.listenToGameUpdates(event.roomId).listen((snapshot) {
       add(_UpdateGameStateEvent(snapshot));
    }, onError: (error) {
       // emit(GameError(error.toString())); // Bloc can't emit from async listener like this easily without specialized handle
    });
  }

  Future<void> _onSubmitWord(SubmitWordEvent event, Emitter<GameViewModelState> emit) async {
    try {
      await _gameService.submitWord(
        roomId: event.roomId,
        playerName: event.playerName,
        word: event.word,
      );
    } catch (e) {
      if (state is GameInProgress) {
         emit(GameInProgress((state as GameInProgress).data, errorMessage: e.toString()));
      }
    }
  }

  Future<void> _onCancelRoom(CancelRoomEvent event, Emitter<GameViewModelState> emit) async {
    await _gameService.endGame(event.roomId);
    emit(RoomCancelled());
  }

  Future<void> _onEndGame(EndGameEvent event, Emitter<GameViewModelState> emit) async {
    try {
      final gameData = await _gameService.getRoomData(event.roomId);
      if (gameData != null && gameData.exists) {
        final data = gameData.data() as Map<String, dynamic>;
        final scores = Map<String, int>.from(data['scores'] ?? {});
        final sortedScores = scores.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        emit(GameOver(sortedScores));
      }
    } catch (e) {
      emit(GameOver([]));
    }
  }

  Future<void> _onLeaveRoom(LeaveRoomEvent event, Emitter<GameViewModelState> emit) async {
    await _gameService.leaveRoom(event.roomId, event.playerName);
    emit(RoomLeaved());
  }

  @override
  Future<void> close() async {
    await _gameSubscription?.cancel();
    return super.close();
  }
}
