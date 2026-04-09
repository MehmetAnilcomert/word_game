part of '../game_view.dart';

class _GameEndButton extends StatelessWidget {
  final String roomId;

  const _GameEndButton({required this.roomId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<GameBloc>().add(EndGame(roomId));
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: context.colorScheme.error,
        backgroundColor: context.colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        LocaleKeys.endGameButton.tr(),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
