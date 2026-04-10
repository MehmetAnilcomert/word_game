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
              MaterialPageRoute<dynamic>(
                builder: (context) => const GameSelectionView(),
              ),
            );
          },
          label: LocaleKeys.wordGameTitle.tr(),
          color: context.colorScheme.primary,
          icon: Icons.font_download,
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          context: context,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (context) => const WordleCreateView(),
              ),
            );
          },
          label: LocaleKeys.wordleButton.tr(),
          color: context.appColors.successColor,
          icon: Icons.grid_on,
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
        backgroundColor: context.colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: const Size(250, 60),
      ),
    );
  }
}
