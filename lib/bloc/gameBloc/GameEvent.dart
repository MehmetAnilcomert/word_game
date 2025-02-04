// Bloc Events
abstract class GameEvent {}

class CreateRoom extends GameEvent {
  final String playerName;
  final String roomId;
  final int endTime;
  final int maxPlayers;
  final int letterNumber;

  CreateRoom(
      {this.letterNumber = 6,
      this.maxPlayers = 2,
      required this.endTime,
      required this.playerName,
      required this.roomId});
}

class JoinRoom extends GameEvent {
  final String roomId;
  final String playerName;

  JoinRoom({required this.roomId, required this.playerName});
}

class StartGame extends GameEvent {
  final String roomId;
  StartGame({required this.roomId});
}

class CancelRoom extends GameEvent {
  final String roomId;
  CancelRoom({required this.roomId});
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

class LeaveRoom extends GameEvent {
  final String roomId;
  final String playerName;
  LeaveRoom({required this.roomId, required this.playerName});
}
