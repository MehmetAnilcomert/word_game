part of '../lobby_view.dart';

class _LobbyHeader extends StatelessWidget {
  final bool isLeader;
  final String roomId;
  final String playerName;
  final Future<void> Function() onExit;

  const _LobbyHeader({
    required this.isLeader,
    required this.roomId,
    required this.playerName,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: context.colorScheme.onPrimary),
          onPressed: onExit,
        ),
        Expanded(
          child: Text(
            LocaleKeys.lobbyTitle.tr(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 50),
      ],
    );
  }
}
