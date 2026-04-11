import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/game/model/game_room.dart';
import 'package:word_game/feature/game/view_model/game_view_model_event.dart';
import 'package:word_game/feature/game/view_model/game_view_model_state.dart';
import 'package:word_game/product/service/interface/i_game_service.dart';
import 'package:word_game/product/state/container/product_state_container.dart';
import 'package:word_game/product/utility/letter_utils.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';

/// [GameViewModel] manages the game logic, room management,
/// and real-time updates for a word game session.
class GameViewModel extends Bloc<GameEvent, GameViewModelState> {
  /// Initializes the [GameViewModel] by reading the [IGameService]
  /// and setting up event handlers.
  GameViewModel()
      : _gameService = ProductContainer.read<IGameService>(),
        super(const GameInitial()) {
    on<CreateRoomEvent>(_onCreateRoom);
    on<JoinRoomEvent>(_onJoinRoom);
    on<StartGameEvent>(_onStartGame);
    on<ListenToGameUpdatesEvent>(_onListenToGameUpdates);
    on<SubmitWordEvent>(_onSubmitWord);
    on<EndGameEvent>(_onEndGame);
    on<CancelRoomEvent>(_onCancelRoom);
    on<LeaveRoomEvent>(_onLeaveRoom);
    on<UpdateGameStateEvent>(_onUpdateGameState);
  }

  final IGameService _gameService;
  StreamSubscription<GameRoom?>? _gameSubscription;

  Future<void> _onCreateRoom(
    CreateRoomEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    emit(const RoomCreating());
    try {
      if (await _gameService.doesRoomExist(event.roomId)) {
        emit(const RoomCreationFailed(errorMessage: LocaleKeys.roomAlreadyExists));
        return;
      }

      final letters = LetterGenerator.generateRandomLetters(
        event.letterNumber,
        event.lang,
      );

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
      emit(RoomCreationFailed(errorMessage: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onJoinRoom(
    JoinRoomEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    emit(RoomJoining(roomId: event.roomId, playerName: event.playerName));
    try {
      final room = await _gameService.getRoomData(event.roomId);
      if (room == null) throw Exception('Room not found');

      if (room.isStarted) throw Exception('Game already started');
      if (!room.isActive) throw Exception('Room not active');
      if (room.players.length >= room.maxPlayers) throw Exception('Room full');
      if (room.players.contains(event.playerName)) {
        throw Exception('Player already in room');
      }

      final players = List<String>.from(room.players)..add(event.playerName);
      await _gameService.updateRoom(event.roomId, {'players': players});

      emit(RoomJoined(roomId: event.roomId, playerName: event.playerName));
      emit(InLobby(players: players));
      add(ListenToGameUpdatesEvent(event.roomId));
    } catch (e) {
      emit(RoomJoinFailed(errorMessage: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onStartGame(
    StartGameEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    try {
      final room = await _gameService.getRoomData(event.roomId);
      if (room != null) {
        if (room.players.length <= 1) {
          emit(
            InLobby(players: room.players, errorMessage: LocaleKeys.notEnoughPlayer),
          );
          return;
        }

        if (room.isStarted) {
          emit(GameInProgress(room));
          return;
        }

        final gameDuration = room.endTime == 0 ? 1 : room.endTime;
        final computedEndTime = DateTime.now()
            .add(Duration(minutes: gameDuration))
            .millisecondsSinceEpoch;

        await _gameService.updateRoom(event.roomId, {
          'isStarted': true,
          'endTime': computedEndTime,
        });

        final updatedRoom = await _gameService.getRoomData(event.roomId);
        if (updatedRoom != null) {
          emit(GameInProgress(updatedRoom));
        }
      }
    } catch (e) {
      emit(GameError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void _onUpdateGameState(
    UpdateGameStateEvent event,
    Emitter<GameViewModelState> emit,
  ) {
    if (event.room == null || !event.room!.isActive) {
      emit(const GameOver([]));
      return;
    }

    final room = event.room!;

    if (room.isStarted) {
      emit(GameInProgress(room));
    } else {
      emit(InLobby(players: room.players));
    }
  }

  Future<void> _onListenToGameUpdates(
    ListenToGameUpdatesEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    await _gameSubscription?.cancel();

    _gameSubscription =
        _gameService.listenToGameUpdates(event.roomId).listen((room) {
      add(UpdateGameStateEvent(room));
    }, onError: (dynamic error) {
      // Handle error
    },);
  }

  Future<void> _onSubmitWord(
    SubmitWordEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    try {
      await _gameService.submitWord(
        roomId: event.roomId,
        playerName: event.playerName,
        word: event.word,
      );
    } catch (e) {
      if (state is GameInProgress) {
        emit(
          GameInProgress(
            (state as GameInProgress).room,
            errorMessage: e.toString().replaceFirst('Exception: ', ''),
          ),
        );
      }
    }
  }

  Future<void> _onCancelRoom(
    CancelRoomEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    await _gameService.endGame(event.roomId);
    emit(const RoomCancelled());
  }

  Future<void> _onEndGame(
    EndGameEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    try {
      final room = await _gameService.getRoomData(event.roomId);
      if (room != null) {
        final sortedScores = room.scores.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        emit(GameOver(sortedScores));
      }
    } catch (e) {
      emit(const GameOver([]));
    }
  }

  Future<void> _onLeaveRoom(
    LeaveRoomEvent event,
    Emitter<GameViewModelState> emit,
  ) async {
    await _gameService.leaveRoom(event.roomId, event.playerName);
    emit(const RoomLeaved());
  }

  @override
  Future<void> close() async {
    await _gameSubscription?.cancel();
    return super.close();
  }
}
