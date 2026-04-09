import 'package:flutter/material.dart';

/// Light Color Scheme for Word Arena
final class LightColorScheme {
  static ColorScheme lightScheme() {
    return const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.purple,
      error: Colors.red,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onError: Colors.white,
    );
  }
}
