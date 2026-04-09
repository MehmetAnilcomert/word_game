part of '../room_view.dart';

class _RoomActionButton extends StatelessWidget {

  const _RoomActionButton({
    required this.isCreateRoom,
    required this.roomState,
  });
  final bool isCreateRoom;
  final RoomState roomState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameViewModel, game_state.GameViewModelState>(
        builder: (context, gameState) {
      final isLoading = gameState is game_state.RoomCreating ||
          gameState is game_state.RoomJoining;
      return ElevatedButton(
        onPressed: isLoading ? null : () => _handleAction(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: isCreateRoom
              ? context.appColors.successColor
              : context.colorScheme.primary,
          backgroundColor: context.colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: isLoading
            ? CircularProgressIndicator(color: context.colorScheme.surface)
            : Text(
                isCreateRoom
                    ? LocaleKeys.createRoomButton.tr()
                    : LocaleKeys.joinRoomButton.tr(),
                style: const TextStyle(fontSize: 18),
              ),
      );
    },);
  }

  void _handleAction(BuildContext context) {
    if (roomState.playerName.isEmpty || roomState.roomID.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(LocaleKeys.fillAllFields.tr()),
            backgroundColor: context.colorScheme.error,),
      );
      return;
    }

    if (isCreateRoom) {
      context.read<GameViewModel>().add(CreateRoomEvent(
            roomId: roomState.roomID,
            playerName: roomState.playerName,
            endTime: roomState.endTime,
            maxPlayers: roomState.playerNumber,
            letterNumber: roomState.letterNumber,
            lang: roomState.lang,
          ),);
    } else {
      context.read<GameViewModel>().add(JoinRoomEvent(
          roomId: roomState.roomID, playerName: roomState.playerName,),);
    }
  }
}
