import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildActionButton(
    BuildContext context,
    GameState state,
    bool isCreateRoom,
    String playerName,
    String roomId,
    int endTime,
    int playerNumber) {
  return ElevatedButton(
    onPressed: state is RoomCreating || state is RoomJoining
        ? null
        : () => _handleAction(
            context, isCreateRoom, playerName, roomId, endTime, playerNumber),
    child: state is RoomCreating || state is RoomJoining
        ? CircularProgressIndicator(color: Colors.white)
        : Text(
            isCreateRoom
                ? S.of(context).createRoomButton
                : S.of(context).joinRoomButton,
            style: TextStyle(fontSize: 18),
          ),
    style: ElevatedButton.styleFrom(
      foregroundColor: isCreateRoom ? Colors.green : Colors.blue,
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
  );
}

void _handleAction(BuildContext context, bool isCreateRoom, String playerName,
    String roomId, int endTime, int playerNumber) {
  if (playerName.isEmpty || roomId.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(S.of(context).fillAllFields),
          backgroundColor: Colors.red),
    );
    return;
  }

  if (isCreateRoom) {
    context.read<GameBloc>().add(CreateRoom(
          roomId: roomId,
          playerName: playerName,
          endTime: endTime,
          maxPlayers: playerNumber,
        ));
  } else {
    context
        .read<GameBloc>()
        .add(JoinRoom(roomId: roomId, playerName: playerName));
  }
}
