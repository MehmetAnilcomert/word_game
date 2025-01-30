import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/widgets/lobby_widgets/exit_dialog.dart';

Widget buildHeaderLobby(
    BuildContext context, bool isLeader, String roomId, String playerName) {
  return Row(
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => _handleExit(context, isLeader, roomId, playerName),
      ),
      Expanded(
        child: Text(
          S.of(context).lobbyTitle,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(width: 50),
    ],
  );
}

Future<void> _handleExit(BuildContext context, bool isLeader, String roomId,
    String playerName) async {
  final shouldExit = await showExitDialog(context);
  if (shouldExit) {
    if (isLeader) {
      context.read<GameBloc>().add(CancelRoom(roomId: roomId));
    } else {
      context
          .read<GameBloc>()
          .add(LeaveRoom(roomId: roomId, playerName: playerName));
    }
  }
}
