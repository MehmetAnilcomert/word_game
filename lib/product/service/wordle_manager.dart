import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

/// [WordleManager] handles loading words from JSON assets and selecting words.
class WordleManager {
  WordleManager._();
  static final WordleManager instance = WordleManager._();

  final Map<String, List<String>> _cachedWords = {};

  /// Loads words from the relevant JSON file based on [langCode].
  Future<List<String>> _loadWords(String langCode) async {
    // Normalize langCode to handle cases like 'en-US' or 'tr-TR'
    final normalizedLang = langCode.split('-').first.toLowerCase();

    if (_cachedWords.containsKey(normalizedLang)) {
      return _cachedWords[normalizedLang]!;
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/words/$normalizedLang.json');
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      final words = jsonList.map((e) => e.toString().toUpperCase().trim()).toList();
      _cachedWords[normalizedLang] = words;
      return words;
    } catch (e) {
      // Return empty if file not found to avoid blocking
      return [];
    }
  }

  /// Returns a random word of the given [length] and [langCode].
  Future<String> getRandomWord(int length, String langCode) async {
    final words = await _loadWords(langCode);
    final filteredWords = words.where((w) => w.length == length).toList();
    
    if (filteredWords.isEmpty) {
      // If no words match length, try to fall back or return a default
      if (langCode.startsWith('tr')) return 'BARDAK';
      return 'APPLE';
    }
    
    return filteredWords[Random().nextInt(filteredWords.length)];
  }

  /// Validates if a [word] exists in the word list for [langCode].
  Future<bool> isValidWord(String word, String langCode) async {
    final words = await _loadWords(langCode);
    if (words.isEmpty) {
      // If word list failed to load, allow everything for now or use a hardcoded small list
      final fallbackWords = langCode.startsWith('tr') ? ['BARDAK', 'KİTAP'] : ['APPLE', 'BREAD'];
      return fallbackWords.contains(word.toUpperCase());
    }
    return words.contains(word.toUpperCase());
  }
}
