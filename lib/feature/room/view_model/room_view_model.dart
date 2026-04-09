import 'package:flutter/material.dart';
import 'package:word_game/product/state/base/base_view_model.dart';

/// State representation for the [RoomViewModel].
class RoomState {
  /// Initializes a [RoomState].
  const RoomState({
    this.playerName = '',
    this.roomID = '',
    this.endTime = 1,
    this.playerNumber = 4,
    this.letterNumber = 6,
    this.lang = 'tr',
  });

  /// Name of the player.
  final String playerName;

  /// Unique ID of the room.
  final String roomID;

  /// Duration of the game in minutes.
  final int endTime;

  /// Maximum number of players allowed in the room.
  final int playerNumber;

  /// Number of letters to be used in the game.
  final int letterNumber;

  /// Language code for the room.
  final String lang;

  /// Creates a copy of [RoomState] with updated fields.
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

/// [RoomViewModel] handles form state and validation for room creation/joining.
class RoomViewModel extends BaseViewModel<RoomState> {

  /// Initializes the [RoomViewModel] and starts listening to controller changes.
  RoomViewModel() : super(const RoomState()) {
    playerNameController.addListener(() {
      emit(state.copyWith(playerName: playerNameController.text));
    });

    roomIDController.addListener(() {
      emit(state.copyWith(roomID: roomIDController.text));
    });
  }
  /// Controller for the player name input field.
  final TextEditingController playerNameController = TextEditingController();

  /// Controller for the room ID input field.
  final TextEditingController roomIDController = TextEditingController();

  /// Updates the game end time in the state.
  void updateEndTime(int time) {
    emit(state.copyWith(endTime: time));
  }

  /// Updates the maximum player count in the state.
  void updatePlayerNumber(int number) {
    emit(state.copyWith(playerNumber: number));
  }

  /// Updates the letter count in the state.
  void updateLetterNumber(int number) {
    emit(state.copyWith(letterNumber: number));
  }

  /// Updates the room language in the state.
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
