import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildAppTitle(BuildContext context) {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 5,
        ),
      ],
    ),
    child: Center(
      child: Text(
        S.of(context).appTitle,
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
