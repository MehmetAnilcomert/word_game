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
          'letters': letters,
          'scores': {},
          'usedWords': [],
          'isActive': true,
          'endTime': endTime,
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

        emit(RoomJoined(roomId: event.roomId, playerName: event.playerName));
      } catch (e) {
        emit(RoomJoinFailed(errorMessage: e.toString()));
      }
    });

    on<StartGame>((event, emit) async {
      final gameDoc =
          await firestore.collection('games').doc(event.roomId).get();

      if (gameDoc.exists) {
        final gameData = gameDoc.data()!;
        final endTime = gameData['endTime'] as int;
        final currentTime = DateTime.now().millisecondsSinceEpoch;

        // Calculate remaining time
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
        final usedWords = List<String>.from(data['usedWords'] ?? []);
        if (usedWords.contains(event.word)) return;

        usedWords.add(event.word);
        final scores = Map<String, int>.from(data['scores'] ?? {});
        scores[event.playerName] =
            (scores[event.playerName] ?? 0) + event.word.length;

        await firestore.collection('games').doc(event.roomId).update({
          'usedWords': usedWords,
          'scores': scores,
        });

        emit(GameInProgress(
            {...data, 'scores': scores, 'usedWords': usedWords}));
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
