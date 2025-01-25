// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Word Challenge Game`
  String get appTitle {
    return Intl.message(
      'Word Challenge Game',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguageTitle {
    return Intl.message(
      'Select Language',
      name: 'selectLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Join or Create Room`
  String get roomScreenTitle {
    return Intl.message(
      'Join or Create Room',
      name: 'roomScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Room ID`
  String get enterRoomId {
    return Intl.message(
      'Enter Room ID',
      name: 'enterRoomId',
      desc: '',
      args: [],
    );
  }

  /// `Create Room`
  String get createRoomButton {
    return Intl.message(
      'Create Room',
      name: 'createRoomButton',
      desc: '',
      args: [],
    );
  }

  /// `Game in Progress`
  String get gameScreenTitle {
    return Intl.message(
      'Game in Progress',
      name: 'gameScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Letters`
  String get lettersLabel {
    return Intl.message(
      'Letters',
      name: 'lettersLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter a word`
  String get enterWord {
    return Intl.message(
      'Enter a word',
      name: 'enterWord',
      desc: '',
      args: [],
    );
  }

  /// `End Game`
  String get endGameButton {
    return Intl.message(
      'End Game',
      name: 'endGameButton',
      desc: '',
      args: [],
    );
  }

  /// `Game Results`
  String get resultScreenTitle {
    return Intl.message(
      'Game Results',
      name: 'resultScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Winner`
  String get winnerLabel {
    return Intl.message(
      'Winner',
      name: 'winnerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Scoreboard`
  String get scoreTableLabel {
    return Intl.message(
      'Scoreboard',
      name: 'scoreTableLabel',
      desc: '',
      args: [],
    );
  }

  /// `Start New Game`
  String get newGameButton {
    return Intl.message(
      'Start New Game',
      name: 'newGameButton',
      desc: '',
      args: [],
    );
  }

  /// `No Winner`
  String get noWinner {
    return Intl.message(
      'No Winner',
      name: 'noWinner',
      desc: '',
      args: [],
    );
  }

  /// `Go Home`
  String get goHome {
    return Intl.message(
      'Go Home',
      name: 'goHome',
      desc: '',
      args: [],
    );
  }

  /// `Enter Player Name`
  String get enterPlayerName {
    return Intl.message(
      'Enter Player Name',
      name: 'enterPlayerName',
      desc: '',
      args: [],
    );
  }

  /// `Join Room`
  String get joinRoomButton {
    return Intl.message(
      'Join Room',
      name: 'joinRoomButton',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get fillAllFields {
    return Intl.message(
      'Please fill all fields',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Room creation failed. Please try another room id.`
  String get roomCreationFailed {
    return Intl.message(
      'Room creation failed. Please try another room id.',
      name: 'roomCreationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not join the room. Please make sure you entered the correct room id.`
  String get roomJoinFailed {
    return Intl.message(
      'Could not join the room. Please make sure you entered the correct room id.',
      name: 'roomJoinFailed',
      desc: '',
      args: [],
    );
  }

  /// `Create Room`
  String get roomScreenTitleCreate {
    return Intl.message(
      'Create Room',
      name: 'roomScreenTitleCreate',
      desc: '',
      args: [],
    );
  }

  /// `Join Room`
  String get roomScreenTitleJoin {
    return Intl.message(
      'Join Room',
      name: 'roomScreenTitleJoin',
      desc: '',
      args: [],
    );
  }

  /// `Rejoin into New Game`
  String get reJoinButton {
    return Intl.message(
      'Rejoin into New Game',
      name: 'reJoinButton',
      desc: '',
      args: [],
    );
  }

  /// `Hurry Up!`
  String get hurryUp {
    return Intl.message(
      'Hurry Up!',
      name: 'hurryUp',
      desc: '',
      args: [],
    );
  }

  /// `Enter Game Duration (in minutes)`
  String get enterEndTime {
    return Intl.message(
      'Enter Game Duration (in minutes)',
      name: 'enterEndTime',
      desc: '',
      args: [],
    );
  }

  /// `Room is not active. Please try joining to an active room.`
  String get roomNotActive {
    return Intl.message(
      'Room is not active. Please try joining to an active room.',
      name: 'roomNotActive',
      desc: '',
      args: [],
    );
  }

  /// `Room is full. Please try joining to another room.`
  String get roomFull {
    return Intl.message(
      'Room is full. Please try joining to another room.',
      name: 'roomFull',
      desc: '',
      args: [],
    );
  }

  /// `Game has already started. You can not join.`
  String get gameAlreadyStarted {
    return Intl.message(
      'Game has already started. You can not join.',
      name: 'gameAlreadyStarted',
      desc: '',
      args: [],
    );
  }

  /// `Playername is already using in the room. Please try another player id.`
  String get playerAlreadyInRoom {
    return Intl.message(
      'Playername is already using in the room. Please try another player id.',
      name: 'playerAlreadyInRoom',
      desc: '',
      args: [],
    );
  }

  /// `Already found.Try another word.`
  String get playerWordRepeated {
    return Intl.message(
      'Already found.Try another word.',
      name: 'playerWordRepeated',
      desc: '',
      args: [],
    );
  }

  /// `Word is already used. Try another word.`
  String get wordAlreadyUsed {
    return Intl.message(
      'Word is already used. Try another word.',
      name: 'wordAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `Word is not valid. Use the given letters.`
  String get invalidWordLetters {
    return Intl.message(
      'Word is not valid. Use the given letters.',
      name: 'invalidWordLetters',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
