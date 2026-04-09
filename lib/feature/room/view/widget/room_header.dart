part of '../room_view.dart';

class _RoomHeader extends StatelessWidget {
  final bool isCreateRoom;

  const _RoomHeader({required this.isCreateRoom});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: context.colorScheme.onPrimary),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
              (route) => false,
            );
          },
        ),
        Text(
          isCreateRoom
              ? LocaleKeys.roomScreenTitleCreate.tr()
              : LocaleKeys.roomScreenTitleJoin.tr(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}
