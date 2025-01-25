import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildScoreBoard(Map<String, int> scores,
    Map<String, List<dynamic>> usedWords, BuildContext context) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            S.of(context).scoreTableLabel,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: scores.entries
                  .map((e) => _buildPlayerWordBoard(
                      (usedWords[e.key] ?? []).cast<String>(), context))
                  .toList(),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPlayerWordBoard(List<String> words, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: words
              .map((word) => Text(
                    word,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[900],
                      decoration:
                          word == context.read<GameBloc>().lastInvalidWord
                              ? TextDecoration.lineThrough
                              : null,
                    ),
                  ))
              .toList(),
        ),
      ],
    ),
  );
}
