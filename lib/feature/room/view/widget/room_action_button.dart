part of '../room_view.dart';

class _RoomActionButton extends StatelessWidget {
  final bool isCreateRoom;
  final RoomState roomState;

  const _RoomActionButton({
    required this.isCreateRoom,
    required this.roomState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, gameState) {
      final isLoading = gameState is RoomCreating || gameState is RoomJoining;
      return ElevatedButton(
        onPressed: isLoading
            ? null
            : () => _handleAction(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: isCreateRoom ? Colors.green : Colors.blue,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                isCreateRoom
                    ? 'createRoomButton'.tr()
                    : 'joinRoomButton'.tr(),
                style: const TextStyle(fontSize: 18),
              ),
      );
    });
  }

  void _handleAction(BuildContext context) {
    if (roomState.playerName.isEmpty || roomState.roomID.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('fillAllFields'.tr()),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (isCreateRoom) {
      context.read<GameBloc>().add(CreateRoom(
            roomId: roomState.roomID,
            playerName: roomState.playerName,
            endTime: roomState.endTime,
            maxPlayers: roomState.playerNumber,
            letterNumber: roomState.letterNumber,
            lang: roomState.lang,
          ));
    } else {
      context
          .read<GameBloc>()
          .add(JoinRoom(roomId: roomState.roomID, playerName: roomState.playerName));
    }
  }
}
