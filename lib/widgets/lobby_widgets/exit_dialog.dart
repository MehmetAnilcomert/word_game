import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';

Future<bool> showExitDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).exitLobbyTitle),
            content: Text(S.of(context).exitLobbyMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(S.of(context).confirm),
              ),
            ],
          );
        },
      ) ??
      false;
}
