import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class RoomState {
  final String playerName;
  final String roomID;
  final int endTime;
  final int playerNumber;

  RoomState({
    this.playerName = '',
    this.roomID = '',
    this.endTime = 1,
    this.playerNumber = 4,
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
  final TextEditingController playerNameController = TextEditingController();
  final TextEditingController roomIDController = TextEditingController();

  RoomCubit() : super(RoomState()) {
    playerNameController.addListener(() {
      emit(state.copyWith(playerName: playerNameController.text));
    });

    roomIDController.addListener(() {
      emit(state.copyWith(roomID: roomIDController.text));
    });
  }

  void updateEndTime(int time) {
    emit(state.copyWith(endTime: time));
  }

  void updatePlayerNumber(int number) {
    emit(state.copyWith(playerNumber: number));
  }

  @override
  Future<void> close() {
    playerNameController.dispose();
    roomIDController.dispose();
    return super.close();
  }
}
