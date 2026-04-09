import 'package:flutter/material.dart';

/// Project general padding items.
final class ProductPadding extends EdgeInsets {
  /// All sides 20 units padding.
  const ProductPadding.allNormal() : super.all(20);

  /// All sides 10 units padding.
  const ProductPadding.allSmall() : super.all(10);

  /// All sides 16 units padding.
  const ProductPadding.allMedium() : super.all(16);

  /// Horizontal 20 units padding.
  const ProductPadding.symmetricHorizontalNormal()
      : super.symmetric(horizontal: 20);

  /// Horizontal 10 units padding.
  const ProductPadding.symmetricHorizontalSmall()
      : super.symmetric(horizontal: 10);

  /// Vertical 20 units padding.
  const ProductPadding.symmetricVerticalNormal()
      : super.symmetric(vertical: 20);

  /// Vertical 10 units padding.
  const ProductPadding.symmetricVerticalSmall() : super.symmetric(vertical: 10);

  /// Top 20 units padding.
  const ProductPadding.onlyTopNormal() : super.only(top: 20);

  /// Bottom 20 units padding.
  const ProductPadding.onlyBottomNormal() : super.only(bottom: 20);

  /// Bottom 10 units padding.
  const ProductPadding.onlyBottomSmall() : super.only(bottom: 10);
}
