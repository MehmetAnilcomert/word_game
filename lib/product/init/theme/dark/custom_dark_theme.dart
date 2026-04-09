import 'package:flutter/material.dart';
import '../app_colors_extension.dart';
import 'dark_color_scheme.dart';

class CustomDarkTheme {
  ThemeData get themeData => ThemeData.dark().copyWith(
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: DarkColorScheme.darkScheme(),
        extensions: [
          AppColorsExtension(
            gradientStart: Colors.blue[900]!,
            gradientEnd: Colors.purple[900]!,
            successColor: Colors.green[800]!,
            warningColor: Colors.orange[800]!,
          ),
        ],
      );
}
