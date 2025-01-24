// Bloc States
abstract class GameState {}

class GameInitial extends GameState {}

class RoomCreating extends GameState {}

class RoomCreated extends GameState {
  final String roomId;
  RoomCreated(this.roomId);
}

class GameInProgress extends GameState {
  final Map<String, dynamic> data;
  GameInProgress(this.data);
}

class GameOver extends GameState {
  final Map<String, dynamic> data;
  GameOver(this.data);
}
