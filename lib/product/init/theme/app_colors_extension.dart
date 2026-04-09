import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color gradientStart;
  final Color gradientEnd;
  final Color successColor;
  final Color warningColor;

  const AppColorsExtension({
    required this.gradientStart,
    required this.gradientEnd,
    required this.successColor,
    required this.warningColor,
  });

  @override
  AppColorsExtension copyWith({
    Color? gradientStart,
    Color? gradientEnd,
    Color? successColor,
    Color? warningColor,
  }) {
    return AppColorsExtension(
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
    );
  }
}
