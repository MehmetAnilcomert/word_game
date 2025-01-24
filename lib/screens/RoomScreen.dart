// Room Screen to Join/Create Game
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/GameScreen.dart';

class RoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).roomScreenTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: S.of(context).enterRoomId),
              onSubmitted: (roomId) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(roomId: roomId),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                final roomId =
                    FirebaseFirestore.instance.collection('games').doc().id;
                FirebaseFirestore.instance.collection('games').doc(roomId).set({
                  'letters': ['A', 'B', 'C', 'D', 'E'],
                  'scores': {},
                  'usedWords': [],
                  'isActive': true,
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(roomId: roomId),
                  ),
                );
              },
              child: Text(S.of(context).createRoomButton),
            ),
          ],
        ),
      ),
    );
  }
}
