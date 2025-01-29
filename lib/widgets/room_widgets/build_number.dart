import 'package:flutter/material.dart';
import 'package:word_game/widgets/room_widgets/number_picker.dart';

Widget buildNumberSelector({
  required String label,
  required IconData icon,
  required int minValue,
  required int maxValue,
  required void Function(int) onChanged,
}) {
  return IntegerNumberSelector(
    label: label,
    icon: icon,
    minValue: minValue,
    maxValue: maxValue,
    onChanged: onChanged,
  );
}
