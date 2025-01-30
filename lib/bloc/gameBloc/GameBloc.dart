import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/bloc/game_repo_cubit.dart';
import 'package:word_game/bloc/timerBloc/TimerBloc.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/repositories/game_repository.dart';
import 'package:word_game/utils/game_utils.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;
  StreamSubscription? gameSubscription;
  TimerBloc? timerBloc;

  GameBloc(BuildContext context, {TimerBloc? timerBloc})
      : gameRepository = context.read<GameRepositoryCubit>().state.repository,
        super(GameInitial()) {
    on<CreateRoom>(_onCreateRoom);
    on<JoinRoom>(_onJoinRoom);
    on<StartGame>(_onStartGame);
    on<ListenToGameUpdates>(_onListenToGameUpdates);
    on<SubmitWord>(_onSubmitWord);
    on<EndGame>(_onEndGame);
    on<CancelRoom>(_onCancelRoom);
    on<LeaveRoom>(_onLeaveRoom);
    on<_UpdateGameState>(_onUpdateGameState);
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
      emit(InLobby(players: [event.playerName]));
      add(ListenToGameUpdates(event.roomId));
    } catch (e) {
      emit(RoomCreationFailed(errorMessage: S.current.roomCreationFailed));
    }
  }

  Future<void> _onJoinRoom(JoinRoom event, Emitter<GameState> emit) async {
    emit(RoomJoining(roomId: event.roomId, playerName: event.playerName));
    try {
      final roomDoc = await gameRepository.getRoomData(event.roomId);
      if (roomDoc == null || !roomDoc.exists) {
        throw S.current.roomJoinFailed;
      }

      final roomData = roomDoc.data()! as Map<String, dynamic>;
      final players = List<String>.from(roomData['players'] ?? []);
      final maxPlayers = roomData['maxPlayers'] as int;

      if (roomData['isStarted']) throw S.current.gameAlreadyStarted;
      if (!roomData['isActive']) throw S.current.roomNotActive;
      if (players.length >= maxPlayers) throw S.current.roomFull;
      if (players.contains(event.playerName))
        throw S.current.playerAlreadyInRoom;

      players.add(event.playerName);
      await gameRepository.updateRoom(event.roomId, {'players': players});

      emit(RoomJoined(roomId: event.roomId, playerName: event.playerName));
      emit(InLobby(players: players));
      add(ListenToGameUpdates(event.roomId));
    } catch (e) {
      emit(RoomJoinFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _onStartGame(StartGame event, Emitter<GameState> emit) async {
    try {
      final roomDoc = await gameRepository.getRoomData(event.roomId);
      if (roomDoc != null && roomDoc.exists) {
        final roomData = roomDoc.data() as Map<String, dynamic>;
        final playerCount = roomData['players']?.length ?? 0;

        // Check if there are enough players to start the game
        if (playerCount <= 1) {
          final players = List<String>.from(roomData['players'] ?? []);
          emit(InLobby(
              players: players, errorMessage: S.current.notEnoughPlayer));
          return;
        }

        // Update the room data to start the game
        await gameRepository.updateRoom(event.roomId, {
          'isStarted': true,
        });

        final updatedDoc = await gameRepository.getRoomData(event.roomId);
        if (updatedDoc != null && updatedDoc.exists) {
          final updatedData = updatedDoc.data() as Map<String, dynamic>;
          emit(GameInProgress(updatedData));
        }
      }
    } catch (e) {
      final roomData = await gameRepository.getRoomData(event.roomId);
      final players = List<String>.from(roomData!['players'] ?? []);
      emit(InLobby(players: players, errorMessage: e.toString()));
      return;
    }
  }

  void _onUpdateGameState(_UpdateGameState event, Emitter<GameState> emit) {
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
      ListenToGameUpdates event, Emitter<GameState> emit) async {
    await gameSubscription?.cancel();

    return emit.forEach<DocumentSnapshot>(
      gameRepository.listenToGameUpdates(event.roomId),
      onData: (snapshot) {
        add(_UpdateGameState(snapshot));
        return state;
      },
      onError: (error, stackTrace) {
        return GameError(error.toString());
      },
    );
  }

  Future<void> _onSubmitWord(SubmitWord event, Emitter<GameState> emit) async {
    try {
      await gameRepository.submitWord(
        roomId: event.roomId,
        playerName: event.playerName,
        word: event.word,
      );
    } catch (e) {
      final roomDoc = await gameRepository.getRoomData(event.roomId);
      emit(GameInProgress(roomDoc!.data() as Map<String, dynamic>,
          errorMessage: e.toString()));
    }
  }

  Future<void> _onCancelRoom(CancelRoom event, Emitter<GameState> emit) async {
    await gameRepository.endGame(event.roomId);
    emit(RoomCancelled());
  }

  Future<void> _onEndGame(EndGame event, Emitter<GameState> emit) async {
    try {
      final gameData = await gameRepository.getRoomData(event.roomId);
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

  Future<void> _onLeaveRoom(LeaveRoom event, Emitter<GameState> emit) async {
    await gameRepository.leaveRoom(event.roomId, event.playerName);
    emit(RoomLeaved());
  }

  @override
  Future<void> close() async {
    await gameSubscription?.cancel();
    return super.close();
  }
}

class _UpdateGameState extends GameEvent {
  final DocumentSnapshot snapshot;
  _UpdateGameState(this.snapshot);
}
