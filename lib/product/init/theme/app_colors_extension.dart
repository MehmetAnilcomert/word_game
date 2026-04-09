import 'package:flutter/material.dart';

/// [AppColorsExtension] is a custom theme extension for application-specific
/// colors that are not covered by the default [ColorScheme].
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  /// Initializes [AppColorsExtension].
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

  /// The start color of the background gradient.
  final Color gradientStart;

  /// The end color of the background gradient.
  final Color gradientEnd;

  /// Color used to represent success states.
  final Color successColor;

  /// Color used to represent warning states.
  final Color warningColor;

  /// Color representing gold (e.g., for 1st place).
  final Color goldColor;

  /// Color representing silver (e.g., for 2nd place).
  final Color silverColor;

  /// Color representing bronze (e.g., for 3rd place).
  final Color bronzeColor;

  /// Color used for card shadows.
  final Color cardShadow;

  /// List of colors used for gold-themed confetti animations.
  final List<Color> goldConfetti;

  /// List of colors used for silver-themed confetti animations.
  final List<Color> silverConfetti;

  /// List of colors used for bronze-themed confetti animations.
  final List<Color> bronzeConfetti;

  /// List of colors used for general confetti animations.
  final List<Color> defaultConfetti;

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
      goldConfetti: goldConfetti,
      silverConfetti: silverConfetti,
      bronzeConfetti: bronzeConfetti,
      defaultConfetti: defaultConfetti,
    );
  }
}