part of '../lobby_view.dart';

class _RoomInfo extends StatelessWidget {

  const _RoomInfo({required this.roomId});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.roomId.tr(),
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            roomId,
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
