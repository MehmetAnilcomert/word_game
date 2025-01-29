import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'package:rxdart/rxdart.dart';

class GameRepository {
  final FirebaseFirestore firestore;

  GameRepository({required this.firestore});

  Future<bool> doesRoomExist(String roomId) async {
    final roomSnapshot = await firestore.collection('games').doc(roomId).get();
    return roomSnapshot.exists;
  }

  Future<void> createRoom({
    required String roomId,
    required String playerName,
    required List<String> letters,
    required int endTime,
    required int maxPlayers,
  }) async {
    await firestore.collection('games').doc(roomId).set({
      'letters': letters,
      'scores': {},
      'usedWords': {},
      'globalUsedWords': [],
      'isActive': true,
      'isStarted': false,
      'endTime': endTime,
      'maxPlayers': maxPlayers,
      'players': [playerName],
    });
  }

  Future<DocumentSnapshot?> getRoomData(String roomId) async {
    return await firestore.collection('games').doc(roomId).get();
  }

  Future<void> updateRoom(String roomId, Map<String, dynamic> updates) async {
    await firestore.collection('games').doc(roomId).update(updates);
  }

  Stream<DocumentSnapshot> listenToGameUpdates(String roomId) {
    return firestore.collection('games').doc(roomId).snapshots();
  }

  Stream<GameState> getGameStateStream(String roomId) {
    return firestore
        .collection('games')
        .doc(roomId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return GameInProgress(snapshot.data()! as Map<String, dynamic>);
      } else {
        return GameOver([]);
      }
    });
  }

  Stream<GameState> getGameStateWithTimer(
      String roomId, Stream<TimerState> timerStream) {
    return Rx.merge([
      getGameStateStream(roomId),
      timerStream.where((state) => state is TimerEnded).map((_) {
        return GameOver([]);
      })
    ]);
  }

  Future<void> submitWord({
    required String roomId,
    required String playerName,
    required String word,
  }) async {
    final doc = await firestore.collection('games').doc(roomId).get();
    if (!doc.exists) return;

    final data = doc.data()!;
    final usedWords = Map<String, dynamic>.from(data['usedWords'] ?? {});
    final globalUsedWords = List<String>.from(data['globalUsedWords'] ?? []);
    final scores = Map<String, int>.from(data['scores'] ?? {});

    usedWords[playerName] = (usedWords[playerName] ?? [])..add(word);
    globalUsedWords.add(word);
    scores[playerName] = (scores[playerName] ?? 0) + word.length;

    await updateRoom(roomId, {
      'usedWords': usedWords,
      'globalUsedWords': globalUsedWords,
      'scores': scores,
    });
  }

  Future<void> endGame(String roomId) async {
    await updateRoom(roomId, {'isActive': false});
  }
}
