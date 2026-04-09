import 'package:flutter/material.dart';

class CustomDarkTheme {
  ThemeData get themeData => ThemeData.dark().copyWith(
        primaryColor: Colors.blue[800],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[800]!,
          secondary: Colors.purple[800]!,
        ),
      );
}
