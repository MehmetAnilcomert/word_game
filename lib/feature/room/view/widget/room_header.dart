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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
              (route) => false,
            );
          },
        ),
        Text(
          isCreateRoom ? 'roomScreenTitleCreate'.tr() : 'roomScreenTitleJoin'.tr(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 48), // To balance the back button
      ],
    );
  }
}
