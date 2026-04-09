import 'package:flutter/material.dart';

/// [LightColorScheme] provides the light theme color palette for Word Arena.
final class LightColorScheme {
  /// Returns the default light [ColorScheme].
  static ColorScheme lightScheme() {
    return const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.purple,
      error: Colors.red,
      onSecondary: Colors.white,
    );
  }
}