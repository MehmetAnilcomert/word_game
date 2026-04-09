import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color gradientStart;
  final Color gradientEnd;
  final Color successColor;
  final Color warningColor;
  final Color goldColor;
  final Color silverColor;
  final Color bronzeColor;
  final Color cardShadow;
  final List<Color> goldConfetti;
  final List<Color> silverConfetti;
  final List<Color> bronzeConfetti;
  final List<Color> defaultConfetti;

  const AppColorsExtension({
    required this.gradientStart,
    required this.gradientEnd,
    required this.successColor,
    required this.warningColor,
    required this.goldColor,
    required this.silverColor,
    required this.bronzeColor,
    required this.cardShadow,
    required this.goldConfetti,
    required this.silverConfetti,
    required this.bronzeConfetti,
    required this.defaultConfetti,
  });

  @override
  AppColorsExtension copyWith({
    Color? gradientStart,
    Color? gradientEnd,
    Color? successColor,
    Color? warningColor,
    Color? goldColor,
    Color? silverColor,
    Color? bronzeColor,
    Color? cardShadow,
    List<Color>? goldConfetti,
    List<Color>? silverConfetti,
    List<Color>? bronzeConfetti,
    List<Color>? defaultConfetti,
  }) {
    return AppColorsExtension(
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      goldColor: goldColor ?? this.goldColor,
      silverColor: silverColor ?? this.silverColor,
      bronzeColor: bronzeColor ?? this.bronzeColor,
      cardShadow: cardShadow ?? this.cardShadow,
      goldConfetti: goldConfetti ?? this.goldConfetti,
      silverConfetti: silverConfetti ?? this.silverConfetti,
      bronzeConfetti: bronzeConfetti ?? this.bronzeConfetti,
      defaultConfetti: defaultConfetti ?? this.defaultConfetti,
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
      goldColor: Color.lerp(goldColor, other.goldColor, t)!,
      silverColor: Color.lerp(silverColor, other.silverColor, t)!,
      bronzeColor: Color.lerp(bronzeColor, other.bronzeColor, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      goldConfetti: goldConfetti, // Not easily lerpable for lists, keep current
      silverConfetti: silverConfetti,
      bronzeConfetti: bronzeConfetti,
      defaultConfetti: defaultConfetti,
    );
  }
}
