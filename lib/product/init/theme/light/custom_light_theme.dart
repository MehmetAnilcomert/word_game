import 'package:flutter/material.dart';
import 'package:word_game/product/init/theme/app_colors_extension.dart';
import 'package:word_game/product/init/theme/light/light_color_scheme.dart';

/// [CustomLightTheme] defines the light theme configuration for the application.
class CustomLightTheme {
  /// Returns the [ThemeData] for light mode.
  ThemeData get themeData => ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: LightColorScheme.lightScheme(),
        extensions: [
          AppColorsExtension(
            gradientStart: Colors.blue[300]!,
            gradientEnd: Colors.purple[300]!,
            successColor: Colors.green,
            warningColor: Colors.orange,
            goldColor: Colors.amber,
            silverColor: Colors.grey[400]!,
            bronzeColor: Colors.brown[300]!,
            cardShadow: Colors.black.withValues(alpha: 0.1),
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