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
          ),
        ],
      );
}
