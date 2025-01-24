// Bloc Events
abstract class GameEvent {}

class StartGame extends GameEvent {
  final String roomId;
  StartGame(this.roomId);
}

class ListenToGameUpdates extends GameEvent {
  final String roomId;
  ListenToGameUpdates(this.roomId);
}

class SubmitWord extends GameEvent {
  final String roomId;
  final String playerName;
  final String word;

  SubmitWord(this.roomId, this.playerName, this.word);
}

class EndGame extends GameEvent {
  final String roomId;
  EndGame(this.roomId);
}
