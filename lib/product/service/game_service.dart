import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/utility/game_utils.dart';

class GameService {
  final FirebaseFirestore firestore;

  GameService({required this.firestore});

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
      'scores': <String, int>{},
      'usedWords': <String, List<dynamic>>{},
      'globalUsedWords': <String>[],
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
        .handleError((dynamic error) {
      throw Exception(error.toString());
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
    final letters = List<String>.from((data['letters'] as List<dynamic>?) ?? []);
    final usedWords = Map<String, dynamic>.from((data['usedWords'] as Map<dynamic, dynamic>?) ?? {});
    final globalUsedWords = List<String>.from((data['globalUsedWords'] as List<dynamic>?) ?? []);
    final scores = Map<String, int>.from((data['scores'] as Map<dynamic, dynamic>?) ?? {});
    final lang = data['lang'] as String;

    if (!GameUtils.isWordHavingValidChars(word, letters)) {
      throw LocaleKeys.invalidWordLetters.tr();
    } else if (!await GameUtils.isWordValid(word, lang)) {
      throw LocaleKeys.wordNotValid.tr();
    }
    if (globalUsedWords.contains(word)) {
      throw LocaleKeys.wordAlreadyUsed.tr();
    }

    final playerWords = (usedWords[playerName] as List<dynamic>?) ?? <dynamic>[];
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
