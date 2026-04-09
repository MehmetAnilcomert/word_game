part of '../room_view.dart';

class _RoomFormContent extends StatelessWidget {
  final bool isCreateRoom;

  const _RoomFormContent({required this.isCreateRoom});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomViewModel, RoomState>(
      builder: (context, roomState) {
        return Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField(
                  controller: context.read<RoomViewModel>().playerNameController,
                  label: 'enterPlayerName'.tr(),
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: context.read<RoomViewModel>().roomIDController,
                  label: 'enterRoomId'.tr(),
                  icon: Icons.meeting_room,
                ),
                const SizedBox(height: 20),
                isCreateRoom
                    ? Column(
                        children: [
                          _IntegerNumberSelector(
                            label: 'enterEndTime'.tr(),
                            icon: Icons.timer,
                            minValue: 1,
                            maxValue: 10,
                            onChanged: (value) => context
                                .read<RoomViewModel>()
                                .updateEndTime(value.toInt()),
                          ),
                          const SizedBox(height: 20),
                          _IntegerNumberSelector(
                            label: 'enterPlayerNumber'.tr(),
                            icon: Icons.person,
                            minValue: 2,
                            maxValue: 10,
                            onChanged: (value) => context
                                .read<RoomViewModel>()
                                .updatePlayerNumber(value.toInt()),
                          ),
                          const SizedBox(height: 20),
                          _IntegerNumberSelector(
                            label: 'enterLetterNumber'.tr(),
                            icon: Icons.question_mark,
                            minValue: 6,
                            maxValue: 12,
                            onChanged: (value) => context
                                .read<RoomViewModel>()
                                .updateLetterNumber(value.toInt()),
                          ),
                          const SizedBox(height: 20),
                          _buildLanguageDropdown(
                            label: 'language'.tr(),
                            selectedValue: roomState.lang,
                            options: LanguageOptions.languageOptions,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<RoomViewModel>().updateLang(value);
                              }
                            },
                          )
                        ],
                      )
                    : const SizedBox(),
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
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required String label,
    required String selectedValue,
    required Map<String, String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.language),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: options.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
