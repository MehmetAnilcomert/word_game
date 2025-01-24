import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildWinnerCard(
    List<MapEntry<String, int>> sortedScores, BuildContext context) {
  return Card(
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            S.of(context).winnerLabel,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            sortedScores.isNotEmpty
                ? sortedScores.first.key
                : S.of(context).noWinner,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
          SizedBox(height: 8),
          Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 64,
          ),
        ],
      ),
    ),
  );
}
