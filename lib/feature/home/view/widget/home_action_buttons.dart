part of '../home_view.dart';

class _HomeActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          label: 'createRoomButton'.tr(),
          color: Colors.green,
          icon: Icons.add_circle_outline,
        ),
        const SizedBox(height: 20),
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
          label: 'joinRoomButton'.tr(),
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
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: const Size(250, 60),
      ),
    );
  }
}
