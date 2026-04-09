part of '../result_view.dart';

class _ResultButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          context: context,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => const RoomView(isCreateRoom: true)),
            );
          },
          icon: Icons.play_arrow,
          label: LocaleKeys.newGameButton.tr(),
          color: context.appColors.successColor,
        ),
        const SizedBox(height: 12),
        _buildButton(
          context: context,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => const RoomView(isCreateRoom: false)),
            );
          },
          icon: Icons.refresh,
          label: LocaleKeys.reJoinButton.tr(),
          color: context.appColors.warningColor,
        ),
        const SizedBox(height: 12),
        _buildButton(
          context: context,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => const HomeView()),
              (route) => false,
            );
          },
          icon: Icons.home,
          label: LocaleKeys.goHome.tr(),
          color: context.colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
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
        backgroundColor: context.colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
