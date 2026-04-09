part of '../room_view.dart';

class _RoomFormContent extends StatelessWidget {

  const _RoomFormContent({required this.isCreateRoom});
  final bool isCreateRoom;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomViewModel, RoomState>(
      builder: (context, roomState) {
        return Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField(
                  context: context,
                  controller:
                      context.read<RoomViewModel>().playerNameController,
                  label: LocaleKeys.enterPlayerName.tr(),
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  context: context,
                  controller: context.read<RoomViewModel>().roomIDController,
                  label: LocaleKeys.enterRoomId.tr(),
                  icon: Icons.meeting_room,
                ),
                const SizedBox(height: 20),
                if (isCreateRoom) Column(
                        children: [
                          _IntegerNumberSelector(
                            label: LocaleKeys.enterEndTime.tr(),
                            icon: Icons.timer,
                            minValue: 1,
                            maxValue: 10,
                            onChanged: (value) => context
                                .read<RoomViewModel>()
                                .updateEndTime(value),
                          ),
                          const SizedBox(height: 20),
                          _IntegerNumberSelector(
                            label: LocaleKeys.enterPlayerNumber.tr(),
                            icon: Icons.person,
                            minValue: 2,
                            maxValue: 10,
                            onChanged: (value) => context
                                .read<RoomViewModel>()
                                .updatePlayerNumber(value),
                          ),
                          const SizedBox(height: 20),
                          _IntegerNumberSelector(
                            label: LocaleKeys.enterLetterNumber.tr(),
                            icon: Icons.question_mark,
                            minValue: 6,
                            maxValue: 12,
                            onChanged: (value) => context
                                .read<RoomViewModel>()
                                .updateLetterNumber(value),
                          ),
                          const SizedBox(height: 20),
                          _buildLanguageDropdown(
                            context: context,
                            label: LocaleKeys.language.tr(),
                            selectedValue: roomState.lang,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<RoomViewModel>().updateLang(value);
                              }
                            },
                          ),
                        ],
                      ) else const SizedBox(),
                const SizedBox(height: 40),
                _RoomActionButton(
                  isCreateRoom: isCreateRoom,
                  roomState: roomState,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required BuildContext context,
    required String label,
    required String selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.language),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
      items: Locales.values.map((locale) {
        return DropdownMenuItem<String>(
          value: locale.locale.languageCode,
          child: Text(
            locale == Locales.en
                ? LocaleKeys.english.tr()
                : LocaleKeys.turkish.tr(),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
