part of '../lobby_view.dart';

class _StartButton extends StatelessWidget {
  final String roomId;

  const _StartButton({required this.roomId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: context.appColors.successColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        context.read<GameBloc>().add(StartGame(roomId: roomId));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(
          LocaleKeys.startGame.tr(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
