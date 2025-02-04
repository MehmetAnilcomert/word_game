import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/utils/game_utils.dart';

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
    required String lang,
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
      'createdAt': FieldValue.serverTimestamp(),
      'lang': lang,
    });
  }

  Future<DocumentSnapshot?> getRoomData(String roomId) async {
    return await firestore.collection('games').doc(roomId).get();
  }

  Future<void> updateRoom(String roomId, Map<String, dynamic> updates) async {
    await firestore.collection('games').doc(roomId).update(updates);
  }

  Stream<DocumentSnapshot> listenToGameUpdates(String roomId) {
    return firestore
        .collection('games')
        .doc(roomId)
        .snapshots()
        .handleError((error) {
      throw error;
    });
  }

  Future<void> submitWord({
    required String roomId,
    required String playerName,
    required String word,
  }) async {
    final doc = await firestore.collection('games').doc(roomId).get();
    if (!doc.exists) return;

    final data = doc.data()!;
    final letters = List<String>.from(data['letters']);
    final usedWords = Map<String, dynamic>.from(data['usedWords'] ?? {});
    final globalUsedWords = List<String>.from(data['globalUsedWords'] ?? []);
    final scores = Map<String, int>.from(data['scores'] ?? {});
    final lang = data['lang'] ?? 'en';

    if (!GameUtils.isWordHavingValidChars(word, letters)) {
      throw S.current.invalidWordLetters;
    } else if (!await GameUtils.isWordValid(word, lang)) {
      throw S.current.wordNotValid;
    }
    if (globalUsedWords.contains(word)) {
      throw S.current.wordAlreadyUsed;
    }

    final playerWords = (usedWords[playerName] ?? []) as List;
    playerWords.add(word);
    usedWords[playerName] = playerWords;
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

  Future<void> leaveRoom(String roomId, String playerName) async {
    await updateRoom(roomId, {
      'players': FieldValue.arrayRemove([playerName])
    });
  }
}
