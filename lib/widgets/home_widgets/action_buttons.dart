import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/RoomScreen.dart';

Widget buildActionButtons(BuildContext context) {
  return Column(
    children: [
      _buildActionButton(
        context: context,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomScreen(isCreateRoom: true),
            ),
          );
        },
        label: S.of(context).createRoomButton,
        color: Colors.green,
        icon: Icons.add_circle_outline,
      ),
      SizedBox(height: 20),
      _buildActionButton(
        context: context,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomScreen(isCreateRoom: false),
            ),
          );
        },
        label: S.of(context).joinRoomButton,
        color: Colors.orange,
        icon: Icons.group_add_outlined,
      ),
    ],
  );
}

Widget _buildActionButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required String label,
  required Color color,
  required IconData icon,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, size: 24),
    label: Text(label, style: TextStyle(fontSize: 18)),
    style: ElevatedButton.styleFrom(
      foregroundColor: color,
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      minimumSize: Size(250, 60),
    ),
  );
}
