import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_game/feature/wordle/view_model/wordle_state.dart';
import 'package:word_game/feature/wordle/view_model/wordle_utils.dart';

/// [WordleViewModel] manages the logic for the Wordle game.
class WordleViewModel extends Cubit<WordleState> {
  /// Initializes the [WordleViewModel].
  WordleViewModel({
    required String initialLang,
    required int initialWordLength,
  }) : super(WordleState(
          lang: initialLang,
          wordLength: initialWordLength,
        ),) {
    _loadScore();
  }

  static const String _scoreKey = 'wordle_total_score';

  /// Starts a new game with the current configuration.
  void startNewGame() {
    final targetWord = WordleUtils.getRandomWord(state.lang, state.wordLength);
    emit(state.copyWith(
      targetWord: targetWord,
      currentGuess: '',
      attempts: [],
      status: WordleGameStatus.playing,
    ),);
  }

  /// Adds a letter to the current guess.
  void addLetter(String letter) {
    if (state.status != WordleGameStatus.playing) return;
    if (state.currentGuess.length < state.wordLength) {
      emit(state.copyWith(currentGuess: state.currentGuess + letter.toUpperCase()));
    }
  }

  /// Removes the last letter from the current guess.
  void removeLetter() {
    if (state.status != WordleGameStatus.playing) return;
    if (state.currentGuess.isNotEmpty) {
      emit(state.copyWith(
        currentGuess: state.currentGuess.substring(0, state.currentGuess.length - 1),
      ),);
    }
  }

  /// Submits the current guess.
  Future<void> submitGuess() async {
    if (state.status != WordleGameStatus.playing) return;
    if (state.currentGuess.length != state.wordLength) return;

    final word = state.currentGuess;
    
    // Validate if word exists
    final isValid = await WordleUtils.isValidWord(word, state.lang);
    if (!isValid) {
      emit(state.copyWith(errorMessage: 'wordNotValid'));
      return;
    }

    final statuses = _evaluateWord(word, state.targetWord);
    final row = WordleRow(word: word, statuses: statuses);
    final attempts = List<WordleRow>.from(state.attempts)..add(row);

    WordleGameStatus status = WordleGameStatus.playing;
    int earnedScore = 0;

    if (word == state.targetWord) {
      status = WordleGameStatus.won;
      // Score: word.length * remaining attempts (max 6)
      // If found in 1st attempt: 6, 2nd: 5 ... 6th: 1
      earnedScore = word.length * (6 - state.attempts.length);
      await _updateScore(earnedScore);
    } else if (attempts.length >= 6) {
      status = WordleGameStatus.lost;
    }

    emit(state.copyWith(
      attempts: attempts,
      currentGuess: '',
      status: status,
      lastEarnedScore: earnedScore,
    ),);
  }

  List<LetterStatus> _evaluateWord(String word, String target) {
    final result = List<LetterStatus>.filled(word.length, LetterStatus.absent);
    final targetList = target.split('');
    final wordList = word.split('');

    // First pass: find correct letters
    for (var i = 0; i < word.length; i++) {
      if (wordList[i] == targetList[i]) {
        result[i] = LetterStatus.correct;
        targetList[i] = ''; // Mark as used
        wordList[i] = '';
      }
    }

    // Second pass: find present but misplaced letters
    for (var i = 0; i < word.length; i++) {
       if (wordList[i] == '') continue;
       final index = targetList.indexOf(wordList[i]);
       if (index != -1) {
         result[i] = LetterStatus.present;
         targetList[index] = '';
       }
    }

    return result;
  }

  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt(_scoreKey) ?? 0;
    emit(state.copyWith(totalScore: score));
  }

  Future<void> _updateScore(int earned) async {
    final prefs = await SharedPreferences.getInstance();
    final newTotal = state.totalScore + earned;
    await prefs.setInt(_scoreKey, newTotal);
    emit(state.copyWith(totalScore: newTotal));
  }

  /// Updates game settings and resets game.
  void updateSettings({String? lang, int? wordLength}) {
     emit(state.copyWith(
       lang: lang ?? state.lang,
       wordLength: wordLength ?? state.wordLength,
       attempts: [],
       currentGuess: '',
       status: WordleGameStatus.playing,
     ),);
     startNewGame();
  }
}
