import 'package:flutter/material.dart';

/// Project general padding items
class ProductPadding extends EdgeInsets {
  const ProductPadding.allNormal() : super.all(20);
  const ProductPadding.allSmall() : super.all(10);
  const ProductPadding.allMedium() : super.all(16);

  const ProductPadding.symmetricHorizontalNormal()
      : super.symmetric(horizontal: 20);
  const ProductPadding.symmetricHorizontalSmall()
      : super.symmetric(horizontal: 10);
  const ProductPadding.symmetricVerticalNormal()
      : super.symmetric(vertical: 20);
  const ProductPadding.symmetricVerticalSmall()
      : super.symmetric(vertical: 10);

  const ProductPadding.onlyTopNormal() : super.only(top: 20);
  const ProductPadding.onlyBottomNormal() : super.only(bottom: 20);
  const ProductPadding.onlyBottomSmall() : super.only(bottom: 10);
}
