// Result Screen
import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/HomeScreen.dart';
import 'package:word_game/screens/RoomScreen.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  ResultScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    final scores = Map<String, int>.from(data['scores'] ?? {});
    final sortedScores = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).resultScreenTitle),
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sortedScores.isNotEmpty
                  ? "${S.of(context).winnerLabel}: ${sortedScores.first.key}"
                  : "${S.of(context).winnerLabel}: ${S.of(context).noWinner}",
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoomScreen(
                                isCreateRoom: true,
                              )));
                },
                child: Text(S.of(context).newGameButton),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false, // Remove all other routes
                  );
                },
                child: Text(S.of(context).goHome),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
