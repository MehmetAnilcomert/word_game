import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';

class CountdownDialog extends StatelessWidget {
  final int countdown;

  const CountdownDialog({Key? key, required this.countdown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).gameStarting),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            countdown.toString(),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(S.of(context).getReady),
        ],
      ),
    );
  }
}
