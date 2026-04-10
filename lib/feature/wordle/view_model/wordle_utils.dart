import 'dart:math';
import 'package:word_game/product/utility/game_utils.dart';

/// Utility class for Wordle game logic.
final class WordleUtils {
  WordleUtils._();

  static final Random _random = Random();

  /// A small list of common words for Wordle when offline or fallback.
  /// In a real app, this would be a larger list or loaded from a file.
  static const Map<String, Map<int, List<String>>> _wordPool = {
    'en': {
      4: ['BOOK', 'GAME', 'WORD', 'PLAY', 'FIRE', 'COLD', 'FAST', 'SLOW'],
      5: ['APPLE', 'BEACH', 'CLOUD', 'DREAM', 'EARTH', 'FLAME', 'GRAPE', 'HEART'],
      6: ['ORANGE', 'BANANA', 'CHERRY', 'PLAYER', 'WINNER', 'PUZZLE', 'ACTION', 'BOTTLE'],
    },
    'tr': {
      4: ['KİTAP', 'OYUN', 'SORU', 'KISA', 'ELMA', 'YAZI', 'BİLGİ', 'ŞANS'],
      5: ['KALEM', 'DENİZ', 'GÜNEŞ', 'BULUT', 'MEYVE', 'ARABA', 'KİRAZ', 'KAVUN'],
      6: ['ANAKART', 'KLAVYE', 'BARDAK', 'KAYISI', 'SÖZLÜK', 'TÜRKÇE', 'GÖZLÜK', 'KİTAPÇ'],
    },
  };

  /// Returns a random word based on language and length.
  static String getRandomWord(String lang, int length) {
    final pool = _wordPool[lang]?[length] ?? _wordPool['en']![5]!;
    return pool[_random.nextInt(pool.length)];
  }

  /// Checks if a word exists in the dictionary.
  static Future<bool> isValidWord(String word, String lang) async {
    return GameUtils.isWordValid(word, lang);
  }
}
