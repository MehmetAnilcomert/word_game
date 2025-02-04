import 'dart:math';

class LetterGenerator {
  static final Random _random = Random();

  // İngilizce harfler
  static const String englishVowels = 'AEIOU';
  static const String englishConsonants = 'BCDFGHJKLMNPRSTVYZ';

  // Türkçe için harfler
  static const String turkishVowels = 'AEIİOÖUÜ';
  static const String turkishConsonants = 'BCÇDFGĞHJKLMNPRSŞTVYZ';

  /// Verilen dil parametresine göre (tr veya en) ve istenen uzunlukta,
  /// en az 2 sesli ve 1 sessiz harf içeren, tekrar etmeyen harf listesi üretir.
  static List<String> generateRandomLetters(int length, String lang) {
    if (length < 3) {
      throw ArgumentError(
          'Length must be at least 3 to include 2 vowels and 1 consonant.');
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

    Set<String> uniqueLetters = {};

    // En az 2 sesli harfi ekle
    while (uniqueLetters.length < 2) {
      uniqueLetters.add(vowels[_random.nextInt(vowels.length)]);
    }

    // Eğer sessiz harf yoksa, bir tane ekle
    if (!uniqueLetters.any((letter) => consonants.contains(letter))) {
      uniqueLetters.add(consonants[_random.nextInt(consonants.length)]);
    }

    // Toplam uzunluğa ulaşana kadar, %30 olasılıkla sesli, %70 olasılıkla sessiz harf seç.
    while (uniqueLetters.length < length) {
      double probability = _random.nextDouble();
      String letter;
      if (probability < 0.3) {
        letter = vowels[_random.nextInt(vowels.length)];
      } else {
        letter = consonants[_random.nextInt(consonants.length)];
      }
      uniqueLetters.add(letter);
    }

    List<String> letters = uniqueLetters.toList();
    letters.shuffle();
    return letters;
  }
}
