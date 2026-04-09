import 'package:word_game/feature/game/model/game_room.dart';

abstract class IGameService {
  Future<bool> doesRoomExist(String roomId);

  Future<void> createRoom({
    required String roomId,
    required String playerName,
    required List<String> letters,
    required int endTime,
    required int maxPlayers,
    required String lang,
  });

  Future<GameRoom?> getRoomData(String roomId);

  Future<void> updateRoom(String roomId, Map<String, dynamic> updates);

  Stream<GameRoom?> listenToGameUpdates(String roomId);

  Future<void> submitWord({
    required String roomId,
    required String playerName,
    required String word,
  });

  Future<void> endGame(String roomId);

  Future<void> leaveRoom(String roomId, String playerName);
}
