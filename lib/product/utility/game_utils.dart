import 'dart:convert';
import 'package:http/http.dart' as http;

/// Utility class for game-related logic and word validation.
final class GameUtils {
  GameUtils._();

  /// Check if the [word] is valid, should contain only the [letters] provided in the list.
  static bool isWordHavingValidChars(String word, List<String> letters) {
    final allowedLetters = letters.map((e) => e.toUpperCase()).toSet();
    final uniqueCharsInWord = word.toUpperCase().split('').toSet();

    return uniqueCharsInWord.difference(allowedLetters).isEmpty;
  }

  /// Check if the [word] is already used in [globalUsedWords].
  static bool isWordUsed(String word, List<String> globalUsedWords) {
    return globalUsedWords.contains(word.toUpperCase());
  }

  /// Validates the [word] using external dictionary APIs based on [lang].
  ///
  /// Currently supports 'en' (English) and 'tr' (Turkish).
  static Future<bool> isWordValid(String word, String lang) async {
    if (lang == 'en') {
      return _isEnglishWordValid(word);
    } else if (lang == 'tr') {
      return _isTurkishWordValid(word);
    } else {
      throw ArgumentError('Language not supported: $lang');
    }
  }

  static Future<bool> _isEnglishWordValid(String word) async {
    final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        return jsonResponse.isNotEmpty;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _isTurkishWordValid(String word) async {
    final url = 'https://sozluk.gov.tr/gts?ara=$word';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        },
      );
      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
