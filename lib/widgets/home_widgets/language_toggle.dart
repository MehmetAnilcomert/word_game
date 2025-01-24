import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/languageBloc.dart';

Widget buildLanguageToggle(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0),
      borderRadius: BorderRadius.circular(30),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      onPressed: () {
        final currentLocale = Localizations.localeOf(context);
        final newLocale =
            currentLocale.languageCode == 'en' ? Locale('tr') : Locale('en');
        context.read<LanguageCubit>().changeLanguage(
            newLocale.languageCode == 'en' ? AppLanguage.en : AppLanguage.tr);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CountryFlag.fromLanguageCode(
          Localizations.localeOf(context).languageCode == 'en' ? 'EN' : 'TR',
          width: 50,
          height: 50,
          shape: Circle(),
        ),
      ),
    ),
  );
}
