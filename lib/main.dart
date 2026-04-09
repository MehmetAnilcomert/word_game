import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:word_game/feature/home/view/home_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/product_initialize.dart';
import 'package:word_game/product/init/product_localization.dart';
import 'package:word_game/product/init/state_initialize.dart';
import 'package:word_game/product/init/theme/dark/custom_dark_theme.dart';
import 'package:word_game/product/init/theme/light/custom_light_theme.dart';

Future<void> main() async {
  await ProductInitialize().startApplication();
  runApp(
    ProductLocalization(
      child: const StateInitialize(
        child: WordArenaApp(),
      ),
    ),
  );
}

class WordArenaApp extends StatelessWidget {
  const WordArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.appTitle.tr(),
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const HomeView(),
    );
  }
}
