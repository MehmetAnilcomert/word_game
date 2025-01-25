import 'package:flutter/material.dart';

Widget buildInputField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType? keyboardType,
}) {
  return TextField(
    keyboardType: keyboardType,
    controller: controller,
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
