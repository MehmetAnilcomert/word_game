import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GameEvent {}

class CreateRoomEvent extends GameEvent {
  final String playerName;
  final String roomId;
  final int endTime;
  final int maxPlayers;
  final int letterNumber;
  final String lang;

  CreateRoomEvent({
    required this.playerName,
    required this.roomId,
    required this.endTime,
    required this.maxPlayers,
    required this.letterNumber,
    required this.lang,
  });
}

class JoinRoomEvent extends GameEvent {
  final String roomId;
  final String playerName;

  JoinRoomEvent({required this.roomId, required this.playerName});
}

class StartGameEvent extends GameEvent {
  final String roomId;
  StartGameEvent({required this.roomId});
}

class ListenToGameUpdatesEvent extends GameEvent {
  final String roomId;
  ListenToGameUpdatesEvent(this.roomId);
}

class SubmitWordEvent extends GameEvent {
  final String roomId;
  final String playerName;
  final String word;

  SubmitWordEvent({required this.roomId, required this.playerName, required this.word});
}

class EndGameEvent extends GameEvent {
  final String roomId;
  EndGameEvent(this.roomId);
}

class CancelRoomEvent extends GameEvent {
  final String roomId;
  CancelRoomEvent({required this.roomId});
}

class LeaveRoomEvent extends GameEvent {
  final String roomId;
  final String playerName;
  LeaveRoomEvent({required this.roomId, required this.playerName});
}

class UpdateGameStateEvent extends GameEvent {
  final DocumentSnapshot snapshot;
  UpdateGameStateEvent(this.snapshot);
}
