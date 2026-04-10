import 'package:flutter/material.dart';

/// Extension on [BuildContext] for easy access to screen dimensions.
extension ScreenSizeExtension on BuildContext {
  /// Returns the screen width.
  double get width => MediaQuery.of(this).size.width;

  /// Returns the screen height.
  double get height => MediaQuery.of(this).size.height;
}
