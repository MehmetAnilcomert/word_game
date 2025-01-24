// Bloc States
abstract class GameState {}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final Map<String, dynamic> data;
  GameInProgress(this.data);
}

class GameOver extends GameState {
  final Map<String, dynamic> data;
  GameOver(this.data);
}
