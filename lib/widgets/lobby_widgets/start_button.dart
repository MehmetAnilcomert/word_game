import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildStartButton(BuildContext context, String roomId) {
  return ElevatedButton(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Text(
        S.of(context).startGame,
        style: TextStyle(fontSize: 18),
      ),
    ),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: () {
      context.read<GameBloc>().add(StartGame(roomId: roomId));
    },
  );
}
