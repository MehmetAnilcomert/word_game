import 'package:flutter/material.dart';
import 'package:word_game/product/init/theme/app_colors_extension.dart';
import 'package:word_game/product/init/theme/dark/dark_color_scheme.dart';

/// [CustomDarkTheme] defines the dark theme configuration for the application.
class CustomDarkTheme {
  /// Returns the [ThemeData] for dark mode.
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
            cardShadow: Colors.black.withValues(alpha: 0.3),
            goldConfetti: const [
              Colors.amber,
              Colors.yellow,
              Colors.orangeAccent,
            ],
            silverConfetti: const [
              Colors.grey,
              Colors.white70,
              Colors.blueGrey,
            ],
            bronzeConfetti: const [
              Colors.brown,
              Colors.orange,
              Colors.deepOrange,
            ],
            defaultConfetti: const [Colors.blue, Colors.green, Colors.purple],
          ),
        ],
      );
}