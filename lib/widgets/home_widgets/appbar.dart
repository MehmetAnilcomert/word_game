import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/widgets/home_widgets/language_toggle.dart';

Widget buildAppBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).appTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        buildLanguageToggle(context),
      ],
    ),
  );
}
