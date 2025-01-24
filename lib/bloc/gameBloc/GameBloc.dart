// Bloc Implementation
import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final FirebaseFirestore firestore;
  final _random = Random(); // Required for random letter generation
  StreamSubscription? gameSubscription;

  GameBloc(this.firestore) : super(GameInitial()) {
    on<CreateRoom>((event, emit) async {
      emit(RoomCreating());

      // Generate random letters for the game
      final letters = _generateRandomLetters(length: 5);

      // Create a game document in Firestore
      final roomId = firestore.collection('games').doc().id;
      await firestore.collection('games').doc(roomId).set({
        'letters': letters,
        'scores': {},
        'usedWords': [],
        'isActive': true,
      });

      // Notify the UI that the room has been created
      emit(RoomCreated(roomId));
    });

    on<StartGame>((event, emit) async {
      final game = await firestore.collection('games').doc(event.roomId).get();
      if (game.exists) {
        emit(GameInProgress(game.data()!));
      }
    });

    on<ListenToGameUpdates>((event, emit) {
      gameSubscription = firestore
          .collection('games')
          .doc(event.roomId)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          emit(GameInProgress(snapshot.data()!));
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

  // Random Letters Generator
  List<String> _generateRandomLetters({required int length}) {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(
        length, (_) => alphabet[_random.nextInt(alphabet.length)]);
  }

  @override
  Future<void> close() {
    gameSubscription?.cancel();
    return super.close();
  }
}
