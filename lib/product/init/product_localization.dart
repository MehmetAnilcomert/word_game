import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:word_game/product/utility/constants/enums/locales.dart';

@immutable

/// A class that sets up localization for the application using EasyLocalization.
class ProductLocalization extends EasyLocalization {
  /// Initializes localization settings for the application.
  ProductLocalization({required super.child, super.key})
      : super(
          supportedLocales: _supportedLocales,
          path: _translationsPath,
          useOnlyLangCode: true,
          fallbackLocale: Locales.en.locale,
        );

  /// List of supported locales in the application
  static final List<Locale> _supportedLocales = Locales.supportedLocales;

  /// The path to the translations assets
  static const String _translationsPath = 'assets/translations';

  /// Updates the application's locale
  static Future<void> updateLang({
    required BuildContext context,
    required Locales locale,
  }) =>
      context.setLocale(locale.locale);

  /// Returns the current language code of the application.
  static String getCurrentLanguageCode(BuildContext context) =>
      EasyLocalization.of(context)?.locale.languageCode ?? Locales.en.locale.languageCode;
}
