import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class GameUtils {
  static final _random = Random();
  static const String vowels = 'AEIOU';
  static const String consonants = 'BCDFGHJKLMNPRSTVYZ';

  // Generate random letters for the game, at least 2 vowels and 1 consonant, and without duplicates
  static List<String> generateRandomLetters(int length) {
    if (length < 2) {
      throw ArgumentError('Length must be at least 2 to include vowels.');
    }

    Set<String> uniqueLetters = {};

    // To ensure at least 2 vowels
    while (uniqueLetters.length < 2) {
      uniqueLetters.add(vowels[_random.nextInt(vowels.length)]);
    }

    // To ensure at least 1 consonant and prevent duplicates
    while (uniqueLetters.length < length) {
      String letter = (Random().nextBool()
          ? vowels
          : consonants)[_random.nextInt(vowels.length)];

      uniqueLetters.add(letter); // to prevent duplicates
    }

    return uniqueLetters.toList()..shuffle(); // finally shuffle the letters
  }

  // Check if the word is valid, should contain only the letters provided in the list
  static bool isWordHavingValidChars(String word, List<String> letters) {
    word = word.toUpperCase();

    // Check if the word has only the letters provided
    return word.split('').every((char) => letters.contains(char));
  }

  // Check if the word is already used
  static bool isWordUsed(String word, List<String> globalUsedWords) {
    return globalUsedWords.contains(word.toUpperCase());
  }

  static Future<bool> isWordValid(String word, String lang) async {
    if (lang == 'en') {
      return await _isEnglishWordValid(word);
    } else if (lang == 'tr') {
      throw ArgumentError('Language not supported: $lang');
    } else {
      throw ArgumentError('Language not supported: $lang');
    }
  }

  static Future<bool> _isEnglishWordValid(String word) async {
    final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.isNotEmpty;
      } else {
        return false;
      }
    } catch (e) {
      print("Error checking word: $e");
      return false;
    }
  }
}
