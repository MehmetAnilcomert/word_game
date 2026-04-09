import 'package:flutter/material.dart';
import 'package:word_game/product/init/theme/app_colors_extension.dart';

/// Extension on [BuildContext] for easy access to theme properties.
extension AppThemeExtension on BuildContext {
  /// Returns the current [AppColorsExtension] from the theme.
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  /// Returns the current [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the background gradient for the app.
  LinearGradient get backgroundGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [appColors.gradientStart, appColors.gradientEnd],
      );
}
