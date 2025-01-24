import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/HomeScreen.dart';
import 'package:word_game/screens/RoomScreen.dart';

Widget buildButtons(BuildContext context) {
  return Column(
    children: [
      _buildButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RoomScreen(isCreateRoom: true)),
          );
        },
        icon: Icons.play_arrow,
        label: S.of(context).newGameButton,
        color: Colors.green,
      ),
      SizedBox(height: 12),
      _buildButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RoomScreen(isCreateRoom: false)),
          );
        },
        icon: Icons.refresh,
        label: S.of(context).reJoinButton,
        color: Colors.orange,
      ),
      SizedBox(height: 12),
      _buildButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        },
        icon: Icons.home,
        label: S.of(context).goHome,
        color: Colors.blue,
      ),
    ],
  );
}

Widget _buildButton({
  required VoidCallback onPressed,
  required IconData icon,
  required String label,
  required Color color,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    label: Text(label),
    style: ElevatedButton.styleFrom(
      foregroundColor: color,
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
  );
}
