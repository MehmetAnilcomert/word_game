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
            goldColor: Colors.amber[600]!,
            silverColor: Colors.grey[500]!,
            bronzeColor: Colors.brown[400]!,
            cardShadow: Colors.black.withOpacity(0.3),
            goldConfetti: const [
              Colors.amber,
              Colors.yellow,
              Colors.orangeAccent
            ],
            silverConfetti: const [
              Colors.grey,
              Colors.white70,
              Colors.blueGrey
            ],
            bronzeConfetti: const [
              Colors.brown,
              Colors.orange,
              Colors.deepOrange
            ],
            defaultConfetti: const [Colors.blue, Colors.green, Colors.purple],
          ),
        ],
      );
}
