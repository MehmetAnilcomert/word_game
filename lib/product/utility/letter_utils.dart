import 'dart:math';

/// Utility class for generating random letters for the game.
final class LetterGenerator {
  LetterGenerator._();

  static final Random _random = Random();

  /// English vowels for generation.
  static const String englishVowels = 'AEIOU';

  /// English consonants for generation.
  static const String englishConsonants = 'BCDFGHJKLMNPRSTVYZ';

  /// Turkish vowels for generation.
  static const String turkishVowels = 'AEIOÖUÜ';

  /// Turkish consonants for generation.
  static const String turkishConsonants = 'BCÇDFGHJKLMNPRSŞTVYZ';

  /// Generates a list of unique random letters based on [lang] and [length].
  ///
  /// Ensures at least 2 vowels and 1 consonant are included.
  /// Throws [ArgumentError] if [length] is less than 3.
  static List<String> generateRandomLetters(int length, String lang) {
    if (length < 3) {
      throw ArgumentError(
        'Length must be at least 3 to include 2 vowels and 1 consonant.',
      );
    }

    final String vowels;
    final String consonants;

    if (lang == 'tr') {
      vowels = turkishVowels;
      consonants = turkishConsonants;
    } else {
      vowels = englishVowels;
      consonants = englishConsonants;
    }

    final uniqueLetters = <String>{};

    while (uniqueLetters.length < 2) {
      uniqueLetters.add(vowels[_random.nextInt(vowels.length)]);
    }

    if (!uniqueLetters.any(consonants.contains)) {
      uniqueLetters.add(consonants[_random.nextInt(consonants.length)]);
    }

    while (uniqueLetters.length < length) {
      final probability = _random.nextDouble();
      final String letter;
      if (probability < 0.3) {
        letter = vowels[_random.nextInt(vowels.length)];
      } else {
        letter = consonants[_random.nextInt(consonants.length)];
      }
      uniqueLetters.add(letter);
    }

    final letters = uniqueLetters.toList()..shuffle();
    return letters;
  }
}
