import 'package:bloc/bloc.dart';

class RoomState {
  final String playerName;
  final String roomID;
  final int endTime;
  final int playerNumber;

  RoomState({
    this.playerName = '',
    this.roomID = '',
    this.endTime = 1,
    this.playerNumber = 2,
  });

  RoomState copyWith({
    String? playerName,
    String? roomID,
    int? endTime,
    int? playerNumber,
  }) {
    return RoomState(
      playerName: playerName ?? this.playerName,
      roomID: roomID ?? this.roomID,
      endTime: endTime ?? this.endTime,
      playerNumber: playerNumber ?? this.playerNumber,
    );
  }
}

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomState());

  void updatePlayerName(String name) {
    emit(state.copyWith(playerName: name));
  }

  void updateRoomID(String id) {
    emit(state.copyWith(roomID: id));
  }

  void updateEndTime(int time) {
    emit(state.copyWith(endTime: time));
  }

  void updatePlayerNumber(int number) {
    emit(state.copyWith(playerNumber: number));
  }
}
