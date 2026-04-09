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
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        'endGameButton'.tr(),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
