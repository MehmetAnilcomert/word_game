// Bloc States
abstract class GameState {}

class GameInitial extends GameState {}

class RoomCreating extends GameState {}

class RoomCreated extends GameState {
  final String roomId;
  final String playerName;

  RoomCreated({required this.roomId, required this.playerName});
}

class RoomJoined extends GameState {
  final String roomId;
  final String playerName;

  RoomJoined({required this.roomId, required this.playerName});
}

class RoomJoining extends GameState {
  final String roomId;
  final String playerName;

  RoomJoining({required this.roomId, required this.playerName});
}

class RoomJoinFailed extends GameState {
  final String errorMessage;

  RoomJoinFailed({required this.errorMessage});
}

class RoomCreationFailed extends GameState {
  final String errorMessage;
  RoomCreationFailed({required this.errorMessage});
}

class GameInProgress extends GameState {
  final Map<String, dynamic> data;
  GameInProgress(this.data);
}

class GameOver extends GameState {
  final Map<String, dynamic> data;
  GameOver(this.data);
}

class GameTimerRunning extends GameState {
  final int remainingTime; // Kalan süre

  GameTimerRunning(this.remainingTime);

  @override
  List<Object?> get props => [remainingTime];
}

class GameTimerFinished extends GameState {}

class GameTimerError extends GameState {
  final String errorMessage;

  GameTimerError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
