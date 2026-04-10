import 'package:equatable/equatable.dart';
import 'package:word_game/feature/wordle/view_model/wordle_view_model.dart';

/// Enum representing the state of a letter in a Wordle row.
enum LetterStatus {
  /// Letter not yet entered.
  initial,

  /// Letter is not in the word.
  absent,

  /// Letter is in the word but at a different position.
  present,

  /// Letter is in the word and at the correct position.
  correct,
}

/// Represents a single attempted word in the Wordle game.
class WordleRow {
  /// Initializes a [WordleRow].
  const WordleRow({required this.word, required this.statuses});

  /// Creates an empty row with the given length.
  factory WordleRow.empty(int length) {
    return WordleRow(
      word: '',
      statuses: List.filled(length, LetterStatus.initial),
    );
  }

  /// The word attempted in this row.
  final String word;

  /// The status of each letter in the word.
  final List<LetterStatus> statuses;
}

/// Enum representing the overall game status.
enum WordleGameStatus {
  /// Game is being played.
  playing,

  /// Game won.
  won,

  /// Game lost.
  lost,
}

/// State representation for the [WordleViewModel].
class WordleState extends Equatable {
  /// Initializes a [WordleState].
  const WordleState({
    this.targetWord = '',
    this.currentGuess = '',
    this.attempts = const [],
    this.status = WordleGameStatus.playing,
    this.lang = 'en',
    this.wordLength = 5,
    this.errorMessage,
    this.totalScore = 0,
    this.lastEarnedScore = 0,
    this.isError = false,
  });

  /// The target word to be guessed.
  final String targetWord;

  /// The current guess being typed.
  final String currentGuess;

  /// The list of attempted guesses.
  final List<WordleRow> attempts;

  /// The overall game status.
  final WordleGameStatus status;

  /// The language for the game.
  final String lang;

  /// The length of the words to be guessed.
  final int wordLength;

  /// An optional error message.
  final String? errorMessage;

  /// Total cached score.
  final int totalScore;

  /// Last earned score for animation.
  final int lastEarnedScore;

  /// Whether the current guess is showing an error animation.
  final bool isError;

  @override
  List<Object?> get props => [
        targetWord,
        currentGuess,
        attempts,
        status,
        lang,
        wordLength,
        errorMessage,
        totalScore,
        lastEarnedScore,
        isError,
      ];

  /// Creates a copy of [WordleState] with updated fields.
  WordleState copyWith({
    String? targetWord,
    String? currentGuess,
    List<WordleRow>? attempts,
    WordleGameStatus? status,
    String? lang,
    int? wordLength,
    String? errorMessage,
    int? totalScore,
    int? lastEarnedScore,
    bool? isError,
  }) {
    return WordleState(
      targetWord: targetWord ?? this.targetWord,
      currentGuess: currentGuess ?? this.currentGuess,
      attempts: attempts ?? this.attempts,
      status: status ?? this.status,
      lang: lang ?? this.lang,
      wordLength: wordLength ?? this.wordLength,
      errorMessage: errorMessage, // Reset error message on copy
      totalScore: totalScore ?? this.totalScore,
      lastEarnedScore: lastEarnedScore ?? this.lastEarnedScore,
      isError: isError ?? false,
    );
  }
}
