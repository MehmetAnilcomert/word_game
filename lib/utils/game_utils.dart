import 'dart:math';

class GameUtils {
  static final Random _random = Random();

  static List<String> generateRandomLetters(int length) {
    const alphabet = 'ABCDEFGHIJKLMNOPRSTUVYZ';
    return List.generate(
        length, (_) => alphabet[_random.nextInt(alphabet.length)]);
  }
}
