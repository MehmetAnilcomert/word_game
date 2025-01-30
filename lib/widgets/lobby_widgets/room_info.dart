import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildRoomInfo(BuildContext context, String roomId) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        S.of(context).roomId,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.97),
          letterSpacing: 1.2,
        ),
      ),
      SizedBox(width: 8),
      Text(
        roomId,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 8.0,
              color: Colors.black.withOpacity(0.9),
            ),
          ],
          letterSpacing: 1.5,
        ),
      ),
    ],
  );
}
