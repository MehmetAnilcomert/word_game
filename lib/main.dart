import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:word_game/bloc/languageBloc.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/modals/language.dart';
import 'package:word_game/screens/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final languageManager = LanguageManager();
  runApp(MyApp(languageManager: languageManager));
}

class MyApp extends StatelessWidget {
  final LanguageManager languageManager;

  MyApp({required this.languageManager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(languageManager),
      child: BlocBuilder<LanguageCubit, AppLanguage>(
        builder: (context, state) {
          Locale _locale = languageManager.locale;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Word Game App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: _locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
