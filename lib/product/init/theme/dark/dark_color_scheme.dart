import 'package:flutter/material.dart';

/// Dark Color Scheme for Word Arena
final class DarkColorScheme {
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
