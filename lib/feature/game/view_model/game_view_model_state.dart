import 'package:word_game/feature/game/model/game_room.dart';
import 'package:word_game/feature/game/view_model/game_view_model.dart';

/// Abstract base class for all [GameViewModel] states.
abstract class GameViewModelState {
  /// Initializes a [GameViewModelState].
  const GameViewModelState();
}

/// Initial state of the [GameViewModel].
class GameInitial extends GameViewModelState {
  /// Initializes a [GameInitial].
  const GameInitial();
}

/// State when a room creation process is in progress.
class RoomCreating extends GameViewModelState {
  /// Initializes a [RoomCreating].
  const RoomCreating();
}

/// State when a room has been successfully created.
class RoomCreated extends GameViewModelState {
  /// Initializes a [RoomCreated].
  const RoomCreated({required this.roomId, required this.playerName});

  /// The ID of the created room.
  final String roomId;

  /// The name of the player who created the room.
  final String playerName;
}

/// State when a player has successfully joined a room.
class RoomJoined extends GameViewModelState {
  /// Initializes a [RoomJoined].
  const RoomJoined({required this.roomId, required this.playerName});

  /// The ID of the joined room.
  final String roomId;

  /// The name of the player who joined the room.
  final String playerName;
}

/// State when a room joining process is in progress.
class RoomJoining extends GameViewModelState {
  /// Initializes a [RoomJoining].
  const RoomJoining({required this.roomId, required this.playerName});

  /// The ID of the room being joined.
  final String roomId;

  /// The name of the player joining the room.
  final String playerName;
}

/// State when joining a room fails.
class RoomJoinFailed extends GameViewModelState {
  /// Initializes a [RoomJoinFailed].
  const RoomJoinFailed({required this.errorMessage});

  /// The error message describing why joining failed.
  final String errorMessage;
}

/// State when creating a room fails.
class RoomCreationFailed extends GameViewModelState {
  /// Initializes a [RoomCreationFailed].
  const RoomCreationFailed({required this.errorMessage});

  /// The error message describing why creation failed.
  final String errorMessage;
}

/// State when a game is actively in progress.
class GameInProgress extends GameViewModelState {
  /// Initializes a [GameInProgress].
  const GameInProgress(this.room, {this.errorMessage});

  /// The current state of the game room.
  final GameRoom room;

  /// An optional error message if an operation failed during game progress.
  final String? errorMessage;
}

/// State when a game has ended.
class GameOver extends GameViewModelState {
  /// Initializes a [GameOver].
  const GameOver(this.data);

  /// The final scores of the game, as list of player names and points.
  final List<MapEntry<String, int>> data;
}

/// Generic error state for the game.
class GameError extends GameViewModelState {
  /// Initializes a [GameError].
  const GameError(this.message);

  /// The error message.
  final String message;
}

/// State when players are in the lobby waiting for the game to start.
class InLobby extends GameViewModelState {
  /// Initializes an [InLobby] state.
  const InLobby({required this.players, this.errorMessage});

  /// List of player names currently in the lobby.
  final List<String> players;

  /// An optional error message if a lobby action failed.
  final String? errorMessage;
}

/// State when a room is cancelled by the owner.
class RoomCancelled extends GameViewModelState {
  /// Initializes a [RoomCancelled].
  const RoomCancelled();
}

/// State when a player leaves the room.
class RoomLeaved extends GameViewModelState {
  /// Initializes a [RoomLeaved].
  const RoomLeaved();
}
