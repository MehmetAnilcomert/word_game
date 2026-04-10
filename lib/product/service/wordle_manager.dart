import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

/// [WordleManager] handles loading words from JSON assets and selecting words.
class WordleManager {
  WordleManager._();
  static final WordleManager instance = WordleManager._();

  /// Cache structure: { 'en': { 5: ["APPLE"], 6: ["PLAYER"] } }
  final Map<String, Map<int, List<String>>> _cachedWordsByLength = {};

  /// Loads words from the relevant JSON file based on [langCode] and [length].
  Future<List<String>> _loadWords(String langCode, int length) async {
    // Normalize langCode to handle cases like 'en-US' or 'tr'
    final normalizedLang = langCode.split('-').first.toLowerCase();

    // If already cached for this language and specific length
    if (_cachedWordsByLength.containsKey(normalizedLang) &&
        _cachedWordsByLength[normalizedLang]!.containsKey(length)) {
      return _cachedWordsByLength[normalizedLang]![length]!;
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/words/$normalizedLang.json');
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

      // Filter words by specified length immediately during parsing
      final filteredWords = jsonList
          .map((e) => e.toString().toUpperCase().trim())
          .where((w) => w.length == length)
          .toList();

      // Initialize nested maps if first time
      _cachedWordsByLength.putIfAbsent(normalizedLang, () => {});
      _cachedWordsByLength[normalizedLang]![length] = filteredWords;

      return filteredWords;
    } catch (e) {
      return [];
    }
  }

  /// Returns a random word of the given [length] and [langCode].
  Future<String> getRandomWord(int length, String langCode) async {
    final words = await _loadWords(langCode, length);
    
    if (words.isEmpty) {
      if (langCode.startsWith('tr')) return 'BARDAK';
      return 'APPLE';
    }
    
    return words[Random().nextInt(words.length)];
  }

  /// Validates if a [word] exists in the word list for [langCode].
  Future<bool> isValidWord(String word, String langCode) async {
    final int length = word.length;
    final words = await _loadWords(langCode, length);
    
    if (words.isEmpty) {
      final fallbackWords = langCode.startsWith('tr') ? ['BARDAK', 'KITAP'] : ['APPLE', 'BREAD'];
      return fallbackWords.contains(word.toUpperCase());
    }
    return words.contains(word.toUpperCase());
  }
}
