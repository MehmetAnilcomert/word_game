import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/modals/language.dart';
import 'dart:ui';

enum AppLanguage { en, tr }

class LanguageCubit extends Cubit<AppLanguage> {
  final LanguageManager languageManager;

  LanguageCubit(this.languageManager) : super(AppLanguage.en);

  void changeLanguage(AppLanguage language) {
    if (language == AppLanguage.tr) {
      languageManager.setLanguage(Locale('tr'));
      emit(AppLanguage.tr);
    } else {
      languageManager.setLanguage(Locale('en'));
      emit(AppLanguage.en);
    }
  }
}
