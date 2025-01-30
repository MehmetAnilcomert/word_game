// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Word Challenge Game"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "createRoomButton": MessageLookupByLibrary.simpleMessage("Create Room"),
        "endGameButton": MessageLookupByLibrary.simpleMessage("End Game"),
        "enterEndTime": MessageLookupByLibrary.simpleMessage(
            "Enter Game Duration (in minutes)"),
        "enterPlayerName":
            MessageLookupByLibrary.simpleMessage("Enter Player Name"),
        "enterPlayerNumber":
            MessageLookupByLibrary.simpleMessage("Enter Number of Players"),
        "enterRoomId": MessageLookupByLibrary.simpleMessage("Enter Room ID"),
        "enterWord": MessageLookupByLibrary.simpleMessage("Enter a word"),
        "exitLobbyMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to exit the game lobby?"),
        "exitLobbyTitle":
            MessageLookupByLibrary.simpleMessage("Exit Game Lobby"),
        "fillAllFields":
            MessageLookupByLibrary.simpleMessage("Please fill all fields"),
        "gameAlreadyStarted": MessageLookupByLibrary.simpleMessage(
            "Game has already started. You can not join."),
        "gameScreenTitle":
            MessageLookupByLibrary.simpleMessage("Game in Progress"),
        "gameStarting": MessageLookupByLibrary.simpleMessage("Game starting"),
        "getReady": MessageLookupByLibrary.simpleMessage("Get Ready!"),
        "goHome": MessageLookupByLibrary.simpleMessage("Go Home"),
        "hurryUp": MessageLookupByLibrary.simpleMessage("Hurry Up!"),
        "invalidWordLetters": MessageLookupByLibrary.simpleMessage(
            "Word is not valid. Use the given letters."),
        "joinRoomButton": MessageLookupByLibrary.simpleMessage("Join Room"),
        "lettersLabel": MessageLookupByLibrary.simpleMessage("Letters"),
        "lobbyTitle": MessageLookupByLibrary.simpleMessage("Game Lobby"),
        "newGameButton": MessageLookupByLibrary.simpleMessage("Start New Game"),
        "noWinner": MessageLookupByLibrary.simpleMessage("No Winner"),
        "notEnoughPlayer": MessageLookupByLibrary.simpleMessage(
            "Not enough players to start the game."),
        "playerAlreadyInRoom": MessageLookupByLibrary.simpleMessage(
            "Playername is already using in the room. Please try another player id."),
        "playerWordRepeated": MessageLookupByLibrary.simpleMessage(
            "Already found.Try another word."),
        "reJoinButton":
            MessageLookupByLibrary.simpleMessage("Rejoin into New Game"),
        "resultScreenTitle":
            MessageLookupByLibrary.simpleMessage("Game Results"),
        "roomCreationFailed": MessageLookupByLibrary.simpleMessage(
            "Room creation failed. Please try another room id."),
        "roomFull": MessageLookupByLibrary.simpleMessage(
            "Room is full. Please try joining to another room."),
        "roomId": MessageLookupByLibrary.simpleMessage("Room ID:"),
        "roomJoinFailed": MessageLookupByLibrary.simpleMessage(
            "Could not join the room. Please make sure you entered the correct room id."),
        "roomNotActive": MessageLookupByLibrary.simpleMessage(
            "Room is not active. Please try joining to an active room."),
        "roomScreenTitle":
            MessageLookupByLibrary.simpleMessage("Join or Create Room"),
        "roomScreenTitleCreate":
            MessageLookupByLibrary.simpleMessage("Create Room"),
        "roomScreenTitleJoin":
            MessageLookupByLibrary.simpleMessage("Join Room"),
        "scoreTableLabel": MessageLookupByLibrary.simpleMessage("Scoreboard"),
        "selectLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Select Language"),
        "startGame": MessageLookupByLibrary.simpleMessage("Start Game"),
        "winnerLabel": MessageLookupByLibrary.simpleMessage("Winner"),
        "wordAlreadyUsed": MessageLookupByLibrary.simpleMessage(
            "Word is already used. Try another word.")
      };
}
