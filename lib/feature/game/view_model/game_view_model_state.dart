import 'package:word_game/feature/game/model/game_room.dart';

abstract class GameViewModelState {}

class GameInitial extends GameViewModelState {}

class RoomCreating extends GameViewModelState {}

class RoomCreated extends GameViewModelState {
  final String roomId;
  final String playerName;

  RoomCreated({required this.roomId, required this.playerName});
}

class RoomJoined extends GameViewModelState {
  final String roomId;
  final String playerName;

  RoomJoined({required this.roomId, required this.playerName});
}

class RoomJoining extends GameViewModelState {
  final String roomId;
  final String playerName;

  RoomJoining({required this.roomId, required this.playerName});
}

class RoomJoinFailed extends GameViewModelState {
  final String errorMessage;

  RoomJoinFailed({required this.errorMessage});
}

class RoomCreationFailed extends GameViewModelState {
  final String errorMessage;
  RoomCreationFailed({required this.errorMessage});
}

class GameInProgress extends GameViewModelState {
  final GameRoom room;
  final String? errorMessage;
  GameInProgress(this.room, {this.errorMessage});
}

class GameOver extends GameViewModelState {
  final List<MapEntry<String, int>> data;
  GameOver(this.data);
}

class GameError extends GameViewModelState {
  final String message;
  GameError(this.message);
}

class InLobby extends GameViewModelState {
  final List<String> players;
  final String? errorMessage;
  InLobby({this.errorMessage, required this.players});
}

class RoomCancelled extends GameViewModelState {}

class RoomLeaved extends GameViewModelState {}
