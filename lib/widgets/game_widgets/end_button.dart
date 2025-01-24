import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildEndGameButton(BuildContext context, String roomId) {
  return ElevatedButton(
    onPressed: () {
      context.read<GameBloc>().add(EndGame(roomId));
    },
    child: Text(
      S.of(context).endGameButton,
      style: TextStyle(fontSize: 18),
    ),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.red,
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
  );
}
