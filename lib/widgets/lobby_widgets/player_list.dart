import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<IconData> animalIcons = [
  FontAwesomeIcons.cat,
  FontAwesomeIcons.dog,
  FontAwesomeIcons.dove,
  FontAwesomeIcons.fish,
  FontAwesomeIcons.hippo,
  FontAwesomeIcons.horse,
  FontAwesomeIcons.spider,
  FontAwesomeIcons.frog,
  FontAwesomeIcons.dragon,
  FontAwesomeIcons.kiwiBird,
  FontAwesomeIcons.otter,
  FontAwesomeIcons.paw,
];

Widget buildPlayerList(BuildContext context, List<String> players) {
  return ListView.builder(
    itemCount: players.length,
    itemBuilder: (context, index) {
      final isLeaderPlayer = index == 0;
      return Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: ListTile(
          leading: FaIcon(
            isLeaderPlayer
                ? FontAwesomeIcons.crown
                : animalIcons[index % animalIcons.length],
            color: isLeaderPlayer ? Colors.amber : null,
            size: 32,
          ),
          title: Text(
            players[index],
            style: TextStyle(
                fontWeight:
                    isLeaderPlayer ? FontWeight.bold : FontWeight.normal),
          ),
          trailing:
              isLeaderPlayer ? Icon(Icons.star, color: Colors.amber) : null,
        ),
      );
    },
  );
}
