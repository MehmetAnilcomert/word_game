import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildWordInput(BuildContext context, String roomId, String playerName) {
  final TextEditingController _controller = TextEditingController();

  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 5,
        ),
      ],
    ),
    child: TextField(
      controller: _controller,
      onSubmitted: (word) {
        if (word.trim().isNotEmpty) {
          context.read<GameBloc>().add(SubmitWord(roomId, playerName, word));
          _controller.clear();
        }
      },
      decoration: InputDecoration(
        hintText: S.of(context).enterWord,
        border: InputBorder.none,
        icon: Icon(Icons.edit, color: Colors.blue[700]),
      ),
      style: TextStyle(fontSize: 18),
    ),
  );
}
