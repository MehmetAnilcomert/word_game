import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:word_game/feature/game/model/game_room.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/service/interface/i_game_service.dart';
import 'package:word_game/product/utility/game_utils.dart';

class FirebaseGameService implements IGameService {
  final FirebaseFirestore _firestore;

  FirebaseGameService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<bool> doesRoomExist(String roomId) async {
    final roomSnapshot = await _firestore.collection('games').doc(roomId).get();
    return roomSnapshot.exists;
  }

  @override
  Future<void> createRoom({
    required String roomId,
    required String playerName,
    required List<String> letters,
    required int endTime,
    required int maxPlayers,
    required String lang,
  }) async {
    await _firestore.collection('games').doc(roomId).set({
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

  @override
  Future<GameRoom?> getRoomData(String roomId) async {
    final doc = await _firestore.collection('games').doc(roomId).get();
    if (!doc.exists || doc.data() == null) return null;
    return GameRoom.fromJson(doc.id, doc.data()!);
  }

  @override
  Future<void> updateRoom(String roomId, Map<String, dynamic> updates) async {
    await _firestore.collection('games').doc(roomId).update(updates);
  }

  @override
  Stream<GameRoom?> listenToGameUpdates(String roomId) {
    return _firestore
        .collection('games')
        .doc(roomId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return GameRoom.fromJson(snapshot.id, snapshot.data()!);
    }).handleError((dynamic error) {
      throw Exception(error.toString());
    });
  }

  @override
  Future<void> submitWord({
    required String roomId,
    required String playerName,
    required String word,
  }) async {
    final doc = await _firestore.collection('games').doc(roomId).get();
    if (!doc.exists || doc.data() == null) return;

    final room = GameRoom.fromJson(doc.id, doc.data()!);

    if (!GameUtils.isWordHavingValidChars(word, room.letters)) {
      throw LocaleKeys.invalidWordLetters.tr();
    } else if (!await GameUtils.isWordValid(word, room.lang)) {
      throw LocaleKeys.wordNotValid.tr();
    }
    if (room.globalUsedWords.contains(word)) {
      throw LocaleKeys.wordAlreadyUsed.tr();
    }

    final playerWords = List<String>.from(room.usedWords[playerName] ?? []);
    playerWords.add(word);
    
    final updatedUsedWords = Map<String, List<String>>.from(room.usedWords);
    updatedUsedWords[playerName] = playerWords;

    final updatedGlobalUsedWords = List<String>.from(room.globalUsedWords);
    updatedGlobalUsedWords.add(word);

    final updatedScores = Map<String, int>.from(room.scores);
    updatedScores[playerName] = (updatedScores[playerName] ?? 0) + word.length;

    await updateRoom(roomId, {
      'usedWords': updatedUsedWords,
      'globalUsedWords': updatedGlobalUsedWords,
      'scores': updatedScores,
    });
  }

  @override
  Future<void> endGame(String roomId) async {
    await updateRoom(roomId, {'isActive': false});
  }

  @override
  Future<void> leaveRoom(String roomId, String playerName) async {
    await updateRoom(roomId, {
      'players': FieldValue.arrayRemove([playerName])
    });
  }
}
