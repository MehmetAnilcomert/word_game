import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/languageBloc.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/RoomScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          Row(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  elevation: MaterialStateProperty.all(0), // No shadow
                  minimumSize: MaterialStateProperty.all(Size(50, 50)),
                ),
                onPressed: () {
                  // Toggle between English and Turkish
                  final currentLocale = Localizations.localeOf(context);
                  final newLocale = currentLocale.languageCode == 'en'
                      ? Locale('tr')
                      : Locale('en');
                  context.read<LanguageCubit>().changeLanguage(
                      newLocale.languageCode == 'en'
                          ? AppLanguage.en
                          : AppLanguage.tr);
                },
                child: Container(
                  child: CountryFlag.fromLanguageCode(
                    Localizations.localeOf(context).languageCode == 'en'
                        ? 'EN'
                        : 'TR',
                    width: 50,
                    height: 50,
                    shape: Circle(),
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Title in Circle
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  S.of(context).appTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30),
            // Create Room Button navigates to the room screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomScreen(
                            isCreateRoom: true,
                          )),
                );
              },
              child: Text(S.of(context).createRoomButton),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomScreen(
                            isCreateRoom: false,
                          )),
                );
              },
              child: Text(S.of(context).joinRoomButton),
            ),
          ],
        ),
      ),
    );
  }
}
