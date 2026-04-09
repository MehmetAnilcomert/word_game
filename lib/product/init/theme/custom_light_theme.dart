import 'package:flutter/material.dart';

class CustomLightTheme {
  ThemeData get themeData => ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.purple,
        ),
      );
}
