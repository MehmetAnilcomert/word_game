import 'dart:convert';
import 'package:http/http.dart' as http;

class GameUtils {
  // Check if the word is valid, should contain only the letters provided in the list
  static bool isWordHavingValidChars(String word, List<String> letters) {
    final allowedLetters = letters.map((e) => e.toUpperCase()).toSet();
    final uniqueCharsInWord = word.toUpperCase().split('').toSet();

    return uniqueCharsInWord.difference(allowedLetters).isEmpty;
  }

  // Check if the word is already used
  static bool isWordUsed(String word, List<String> globalUsedWords) {
    return globalUsedWords.contains(word.toUpperCase());
  }

  static Future<bool> isWordValid(String word, String lang) async {
    if (lang == 'en') {
      return await _isEnglishWordValid(word);
    } else if (lang == 'tr') {
      return await _isTurkishWordValid(word);
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
      print("Error checking word: $e");
      return false;
    }
  }

  static Future<bool> _isTurkishWordValid(String word) async {
    final url = 'https://sozluk.gov.tr/gts?ara=$word';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          // Gerçek bir tarayıcıya benzetmek için User-Agent ekleniyor
          // Adding User-Agent to mimic a real browser, to prevent 403 error
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"
        },
      );
      if (response.statusCode == 200) {
        // TDK'nın endpoint'i, kelime bulunduğunda JSON formatında sonuç döner.
        // The TDK endpoint returns the result in JSON format when the word is found.
        final dynamic jsonResponse = jsonDecode(response.body);
        // Sözlük endpointinin yapısı gereği eğer dönen veri liste biçiminde ve boş değilse, kelime geçerli sayılır.
        // If the returned data is in list format and not empty due to endpoint structure, the word is considered valid.
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error checking Turkish word: $e");
      return false;
    }
  }
}
