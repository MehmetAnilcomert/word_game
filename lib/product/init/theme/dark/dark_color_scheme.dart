import 'package:flutter/material.dart';

/// [DarkColorScheme] provides the dark theme color palette for Word Arena.
final class DarkColorScheme {
  /// Returns the default dark [ColorScheme].
  static ColorScheme darkScheme() {
    return ColorScheme.dark(
      primary: Colors.blue[800]!,
      secondary: Colors.purple[800]!,
      error: Colors.red[800]!,
      surface: const Color(0xFF1E1E1E),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
      onError: Colors.white,
    );
  }
}