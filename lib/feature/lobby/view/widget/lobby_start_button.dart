part of '../lobby_view.dart';

class _StartButton extends StatelessWidget {

  const _StartButton({required this.roomId});
  final String roomId;

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
        context.read<GameViewModel>().add(StartGameEvent(roomId: roomId));
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
