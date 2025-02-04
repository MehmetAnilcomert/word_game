import 'package:flutter/material.dart';

Widget buildLanguageDropdown({
  required String label,
  required String selectedValue,
  required Map<String, String> options,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: selectedValue,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(Icons.language),
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
