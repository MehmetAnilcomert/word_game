import 'package:word_game/feature/game/model/game_room.dart';

/// Interface for game-related services.
/// Defines the core contract for room management, game flow, and updates.
abstract class IGameService {
  /// Checks if a room with the given [roomId] exists in the data store.
  Future<bool> doesRoomExist(String roomId);

  /// Creates a new game room with specified parameters.
  Future<void> createRoom({
    required String roomId,
    required String playerName,
    required List<String> letters,
    required int endTime,
    required int maxPlayers,
    required String lang,
  });

  /// Fetches the current data for a room by its [roomId].
  Future<GameRoom?> getRoomData(String roomId);

  /// Updates the specified [roomId] with the provided [updates] map.
  Future<void> updateRoom(String roomId, Map<String, dynamic> updates);

  /// Provides a real-time stream of game room updates for a specific [roomId].
  Stream<GameRoom?> listenToGameUpdates(String roomId);

  /// Submits a [word] for a [playerName] in a specific [roomId].
  /// Validates letters, word validity, and previous usage.
  Future<void> submitWord({
    required String roomId,
    required String playerName,
    required String word,
  });

  /// Marks a specific [roomId] as inactive or ended.
  Future<void> endGame(String roomId);

  /// Removes a [playerName] from the list of players in a specific [roomId].
  Future<void> leaveRoom(String roomId, String playerName);
}