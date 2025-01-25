import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/bloc/timerBloc/TimerBloc.dart';
import 'package:word_game/bloc/timerBloc/TimerEvent.dart';
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'package:word_game/generated/l10n.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final FirebaseFirestore firestore;
  final _random = Random(); // Random letter generator
  StreamSubscription? gameSubscription;
  TimerBloc? timerBloc;
  String? lastInvalidWord;

  GameBloc(this.firestore, {this.timerBloc}) : super(GameInitial()) {
    on<CreateRoom>((event, emit) async {
      emit(RoomCreating());

      try {
        final roomId = event.roomId;

        // Check if the room ID already exists
        final roomSnapshot =
            await firestore.collection('games').doc(roomId).get();

        if (roomSnapshot.exists) {
          emit(RoomCreationFailed(errorMessage: S.current.roomCreationFailed));
          return;
        }

        // Generate random letters
        final letters = _generateRandomLetters(length: 5);

        // Set end time (e.g., 5 minutes from now)
        final endTime = DateTime.now()
            .add(Duration(minutes: event.endTime))
            .millisecondsSinceEpoch;

        // Create a new game in Firestore
        await firestore.collection('games').doc(roomId).set({
          'letters': letters, // To store random letters
          'scores': {}, // To store player's scores
          'usedWords': {}, // To store player's used words
          'globalUsedWords': [], // To prevent duplicate words
          'isActive': true, // Game is active so players can be joined.
          'isStarted':
              false, // Game is not started yet, it will be started by the host.
          'endTime': endTime,
          'maxPlayers':
              event.maxPlayers, // To limit the number of players in a game
          'players': [event.playerName],
        });

        emit(RoomCreated(roomId: roomId, playerName: event.playerName));
      } catch (e) {
        emit(RoomCreationFailed(errorMessage: S.current.roomCreationFailed));
      }
    });

    on<JoinRoom>((event, emit) async {
      emit(RoomJoining(roomId: event.roomId, playerName: event.playerName));

      try {
        final roomDoc =
            await firestore.collection('games').doc(event.roomId).get();

        if (!roomDoc.exists) {
          throw Exception(S.current.roomJoinFailed);
        }

        final roomData = roomDoc.data()!;
        final isActive = roomData['isActive'] as bool;
        final isStarted = roomData['isStarted'] as bool;
        final players = List<String>.from(roomData['players'] ?? []);
        final maxPlayers = roomData['maxPlayers'] as int;

        if (!isActive) {
          throw Exception(S.current.roomNotActive);
        }

        if (isStarted) {
          throw Exception(S.current.gameAlreadyStarted);
        }

        if (players.length >= maxPlayers) {
          throw Exception(S.current.roomFull);
        }

        if (players.contains(event.playerName)) {
          throw Exception(S.current.playerAlreadyInRoom);
        }

        players.add(event.playerName);

        await firestore
            .collection('games')
            .doc(event.roomId)
            .update({'players': players});

        emit(RoomJoined(roomId: event.roomId, playerName: event.playerName));
      } catch (e) {
        emit(RoomJoinFailed(errorMessage: e.toString()));
      }
    });

    on<StartGame>((event, emit) async {
      final gameDoc =
          await firestore.collection('games').doc(event.roomId).get();

      if (gameDoc.exists) {
        await firestore
            .collection('games')
            .doc(event.roomId)
            .update({'isStarted': true});

        final gameData = gameDoc.data()!;
        final endTime = gameData['endTime'] as int;
        final currentTime = DateTime.now().millisecondsSinceEpoch;

        final remainingTime =
            (endTime - currentTime).clamp(0, double.infinity).toInt();

        if (remainingTime > 0) {
          timerBloc!.add(StartTimer(remainingTime)); // Start the timer
        } else {
          add(EndGame(event.roomId)); // End the game if the time is up
        }

        emit(GameInProgress(gameData));
      }
    });

    on<ListenToGameUpdates>((event, emit) {
      gameSubscription = firestore
          .collection('games')
          .doc(event.roomId)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          final gameData = snapshot.data()!;
          final isActive = gameData['isActive'] as bool;

          if (isActive) {
            emit(GameInProgress(gameData));
          } else {
            emit(GameOver(gameData));
          }
        }
      });

      timerBloc?.stream.listen((timerState) {
        if (timerState is TimerEnded) {
          add(EndGame(event.roomId)); // Trigger EndGame when the timer ends.
        }
      });
    });

    on<SubmitWord>((event, emit) async {
      final doc = await firestore.collection('games').doc(event.roomId).get();
      if (doc.exists) {
        final data = doc.data()!;
        final letters = List<String>.from(data['letters']);
        final usedWords =
            (data['usedWords'] as Map<String, dynamic>?)?.map((key, value) {
                  return MapEntry(key, List<String>.from(value as List));
                }) ??
                {};
        final globalUsedWords =
            List<String>.from(data['globalUsedWords'] ?? []);

        final wordLetters = event.word.toUpperCase().split('');
        final isValidWord =
            wordLetters.every((letter) => letters.contains(letter));

        String? errorMessage;
        if (!isValidWord) {
          errorMessage = S.current.invalidWordLetters;
        } else if (globalUsedWords.contains(event.word)) {
          errorMessage = S.current.wordAlreadyUsed;
        }

        if (errorMessage != null) {
          emit(WordSubmissionError(errorMessage: errorMessage));
          emit(GameInProgress(data));
          return;
        }

        // Existing word submission logic
        usedWords[event.playerName] ??= [];
        usedWords[event.playerName]!.add(event.word);
        globalUsedWords.add(event.word);

        final scores = Map<String, int>.from(data['scores'] ?? {});
        scores[event.playerName] =
            (scores[event.playerName] ?? 0) + event.word.length;

        await firestore.collection('games').doc(event.roomId).update({
          'usedWords': usedWords,
          'globalUsedWords': globalUsedWords,
          'scores': scores,
        });

        emit(GameInProgress({
          ...data,
          'scores': scores,
          'usedWords': usedWords,
          'globalUsedWords': globalUsedWords
        }));
      }
    });

    on<EndGame>((event, emit) async {
      // Mark the game as inactive
      await firestore
          .collection('games')
          .doc(event.roomId)
          .update({'isActive': false});
      final doc = await firestore.collection('games').doc(event.roomId).get();
      if (doc.exists) {
        emit(GameOver(doc.data()!));
      }
    });
  }

  // Random letters generator
  List<String> _generateRandomLetters({required int length}) {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(
        length, (_) => alphabet[_random.nextInt(alphabet.length)]);
  }

  @override
  Future<void> close() {
    gameSubscription?.cancel();
    // Cancel the timer when the Bloc is closed
    return super.close();
  }
}
