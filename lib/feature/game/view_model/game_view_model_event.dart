import 'package:word_game/feature/game/model/game_room.dart';

/// Base class for all game-related events.
abstract class GameEvent {}

/// Event triggered to create a new game room.
class CreateRoomEvent extends GameEvent {
  /// Creates a [CreateRoomEvent].
  CreateRoomEvent({
    required this.playerName,
    required this.roomId,
    required this.endTime,
    required this.maxPlayers,
    required this.letterNumber,
    required this.lang,
  });

  /// Name of the player creating the room.
  final String playerName;

  /// Unique identifier for the room.
  final String roomId;

  /// Duration of the game in minutes.
  final int endTime;

  /// Maximum number of players allowed.
  final int maxPlayers;

  /// Number of random letters to generate.
  final int letterNumber;

  /// Language of the game keywords.
  final String lang;
}

/// Event triggered when a player wants to join an existing room.
class JoinRoomEvent extends GameEvent {
  /// Creates a [JoinRoomEvent].
  JoinRoomEvent({required this.roomId, required this.playerName});

  /// ID of the room to join.
  final String roomId;

  /// Name of the player joining.
  final String playerName;
}

/// Event to signal the start of the game.
class StartGameEvent extends GameEvent {
  /// Creates a [StartGameEvent].
  StartGameEvent({required this.roomId});

  /// ID of the room where the game starts.
  final String roomId;
}

/// Event to start listening to real-time room updates.
class ListenToGameUpdatesEvent extends GameEvent {
  /// Creates a [ListenToGameUpdatesEvent].
  ListenToGameUpdatesEvent(this.roomId);

  /// ID of the room to listen to.
  final String roomId;
}

/// Event triggered when a player submits a word.
class SubmitWordEvent extends GameEvent {
  /// Creates a [SubmitWordEvent].
  SubmitWordEvent({
    required this.roomId,
    required this.playerName,
    required this.word,
  });

  /// ID of the current room.
  final String roomId;

  /// Name of the player submitting the word.
  final String playerName;

  /// The word being submitted.
  final String word;
}

/// Event to signal the end of a game session.
class EndGameEvent extends GameEvent {
  /// Creates an [EndGameEvent].
  EndGameEvent(this.roomId);

  /// ID of the room ending.
  final String roomId;
}

/// Event to cancel and close a room.
class CancelRoomEvent extends GameEvent {
  /// Creates a [CancelRoomEvent].
  CancelRoomEvent({required this.roomId});

  /// ID of the room to cancel.
  final String roomId;
}

/// Event triggered when a player leaves the room.
class LeaveRoomEvent extends GameEvent {
  /// Creates a [LeaveRoomEvent].
  LeaveRoomEvent({required this.roomId, required this.playerName});

  /// ID of the room being left.
  final String roomId;

  /// Name of the player leaving.
  final String playerName;
}

/// Event to update the internal bloc state with new [GameRoom] data.
class UpdateGameStateEvent extends GameEvent {
  /// Creates an [UpdateGameStateEvent].
  UpdateGameStateEvent(this.room);

  /// The updated room data.
  final GameRoom? room;
}
