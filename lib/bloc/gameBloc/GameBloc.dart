import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/bloc/timerBloc/TimerBloc.dart';
import 'package:word_game/bloc/timerBloc/TimerEvent.dart';
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/repositories/game_repository.dart';
import 'package:word_game/utils/game_utils.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;
  StreamSubscription? gameSubscription;
  TimerBloc? timerBloc;

  GameBloc(this.gameRepository, {this.timerBloc}) : super(GameInitial()) {
    on<CreateRoom>(_onCreateRoom);
    on<JoinRoom>(_onJoinRoom);
    on<StartGame>(_onStartGame);
    on<ListenToGameUpdates>(_onListenToGameUpdates);
    on<SubmitWord>(_onSubmitWord);
    on<EndGame>(_onEndGame);
  }

  Future<void> _onCreateRoom(CreateRoom event, Emitter<GameState> emit) async {
    emit(RoomCreating());
    try {
      if (await gameRepository.doesRoomExist(event.roomId)) {
        emit(RoomCreationFailed(errorMessage: S.current.roomCreationFailed));
        return;
      }

      final letters = GameUtils.generateRandomLetters(5);
      final endTime = DateTime.now()
          .add(Duration(minutes: event.endTime))
          .millisecondsSinceEpoch;

      await gameRepository.createRoom(
        roomId: event.roomId,
        playerName: event.playerName,
        letters: letters,
        endTime: endTime,
        maxPlayers: event.maxPlayers,
      );

      emit(RoomCreated(roomId: event.roomId, playerName: event.playerName));
    } catch (_) {
      emit(RoomCreationFailed(errorMessage: S.current.roomCreationFailed));
    }
  }

  Future<void> _onJoinRoom(JoinRoom event, Emitter<GameState> emit) async {
    emit(RoomJoining(roomId: event.roomId, playerName: event.playerName));
    try {
      final roomDoc = await gameRepository.getRoomData(event.roomId);
      if (roomDoc == null || !roomDoc.exists) {
        throw Exception(S.current.roomJoinFailed);
      }

      final roomData = roomDoc.data()! as Map<String, dynamic>;
      final players = List<String>.from(roomData['players'] ?? []);
      final maxPlayers = roomData['maxPlayers'] as int;

      if (roomData['isStarted']) throw Exception(S.current.gameAlreadyStarted);
      if (!roomData['isActive']) throw Exception(S.current.roomNotActive);
      if (players.length >= maxPlayers) throw Exception(S.current.roomFull);
      if (players.contains(event.playerName))
        throw Exception(S.current.playerAlreadyInRoom);

      players.add(event.playerName);
      await gameRepository.updateRoom(event.roomId, {'players': players});

      emit(RoomJoined(roomId: event.roomId, playerName: event.playerName));
    } catch (e) {
      emit(RoomJoinFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _onStartGame(StartGame event, Emitter<GameState> emit) async {
    final roomDoc = await gameRepository.getRoomData(event.roomId);
    if (roomDoc != null && roomDoc.exists) {
      final roomData = roomDoc.data() as Map<String, dynamic>;
      await gameRepository.updateRoom(event.roomId, {'isStarted': true});
      emit(GameInProgress(roomData));

      final endTime = roomData['endTime'] as int;
      final remainingTime = (endTime - DateTime.now().millisecondsSinceEpoch)
          .clamp(0, double.infinity)
          .toInt();

      if (remainingTime > 0) {
        timerBloc?.add(StartTimer(remainingTime));
      } else {
        add(EndGame(event.roomId));
      }
    }
  }

  void _onListenToGameUpdates(
      ListenToGameUpdates event, Emitter<GameState> emit) {
    gameSubscription =
        gameRepository.listenToGameUpdates(event.roomId).listen((snapshot) {
      if (snapshot.exists) {
        emit(GameInProgress(snapshot.data()! as Map<String, dynamic>));
      } else {
        emit(GameOver({}));
      }
    });

    timerBloc?.stream.listen((timerState) {
      if (timerState is TimerEnded) {
        add(EndGame(event.roomId));
      }
    });
  }

  Future<void> _onSubmitWord(SubmitWord event, Emitter<GameState> emit) async {
    await gameRepository.submitWord(
      roomId: event.roomId,
      playerName: event.playerName,
      word: event.word,
    );
  }

  Future<void> _onEndGame(EndGame event, Emitter<GameState> emit) async {
    try {
      final gameData = await gameRepository.getRoomData(event.roomId);
      if (gameData != null && gameData.exists) {
        final data = gameData.data() as Map<String, dynamic>;
        emit(GameOver(data)); // End the game with the result data
      }
    } catch (e) {
      emit(GameOver({})); // If an error occurs, just end the game
    }
  }
}
