import 'package:flutter/material.dart';
import '../app_colors_extension.dart';
import 'light_color_scheme.dart';

class CustomLightTheme {
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
            cardShadow: Colors.black.withOpacity(0.1),
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
