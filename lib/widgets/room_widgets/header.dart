import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/HomeScreen.dart';

Widget buildHeader(BuildContext context, bool isCreateRoom) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        },
      ),
      Text(
        isCreateRoom
            ? S.of(context).roomScreenTitleCreate
            : S.of(context).roomScreenTitleJoin,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(width: 48), // To balance the back button
    ],
  );
}
