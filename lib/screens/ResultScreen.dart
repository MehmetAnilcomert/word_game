// Result Screen
import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  ResultScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    final scores = Map<String, int>.from(data['scores'] ?? {});
    final sortedScores = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).resultScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${S.of(context).winnerLabel}: ${sortedScores.first.key}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(S.of(context).scoreTableLabel, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            ...sortedScores.map((entry) => ListTile(
                  title: Text(entry.key),
                  trailing: Text(entry.value.toString()),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).newGameButton),
            ),
          ],
        ),
      ),
    );
  }
}
