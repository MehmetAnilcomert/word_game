part of '../result_view.dart';

class _ResultButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const RoomView(isCreateRoom: true)),
            );
          },
          icon: Icons.play_arrow,
          label: 'newGameButton'.tr(),
          color: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const RoomView(isCreateRoom: false)),
            );
          },
          icon: Icons.refresh,
          label: 'reJoinButton'.tr(),
          color: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
              (route) => false,
            );
          },
          icon: Icons.home,
          label: 'goHome'.tr(),
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
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
