import 'package:flutter/material.dart';
import 'package:word_game/product/state/base/base_view_model.dart';
import 'package:word_game/product/model/lang_options.dart';

class RoomState {
  final String playerName;
  final String roomID;
  final int endTime;
  final int playerNumber;
  final int letterNumber;
  final String lang;

  const RoomState({
    this.playerName = '',
    this.roomID = '',
    this.endTime = 1,
    this.playerNumber = 4,
    this.letterNumber = 6,
    this.lang = 'tr',
  });

  RoomState copyWith({
    String? playerName,
    String? roomID,
    int? endTime,
    int? playerNumber,
    int? letterNumber,
    String? lang,
  }) {
    return RoomState(
      playerName: playerName ?? this.playerName,
      roomID: roomID ?? this.roomID,
      endTime: endTime ?? this.endTime,
      playerNumber: playerNumber ?? this.playerNumber,
      letterNumber: letterNumber ?? this.letterNumber,
      lang: lang ?? this.lang,
    );
  }
}

class RoomViewModel extends BaseViewModel<RoomState> {
  final TextEditingController playerNameController = TextEditingController();
  final TextEditingController roomIDController = TextEditingController();

  RoomViewModel() : super(const RoomState()) {
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

  void updateLetterNumber(int number) {
    emit(state.copyWith(letterNumber: number));
  }

  void updateLang(String value) {
    emit(state.copyWith(lang: value));
  }

  @override
  Future<void> close() {
    playerNameController.dispose();
    roomIDController.dispose();
    return super.close();
  }
}
