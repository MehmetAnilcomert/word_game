import 'package:confetti/confetti.dart';
import 'package:word_game/product/state/base/base_view_model.dart';

/// Possible rank positions for determining confetti intensity.
enum RankPosition {
  /// First place rank.
  first,

  /// Second place rank.
  second,

  /// Third place rank.
  third,

  /// Rank lower than third.
  other
}

/// [ResultViewModel] manages the logic and animations for the results screen.
class ResultViewModel extends BaseViewModel<RankPosition?> {
  /// Initializes [ResultViewModel] with a [ConfettiController].
  ResultViewModel()
      : confettiController =
            ConfettiController(duration: const Duration(seconds: 5)),
        super(null);

  /// Controller for the confetti animation.
  final ConfettiController confettiController;

  /// Starts the confetti animation based on the player's [rank].
  void startConfetti(int rank) {
    RankPosition position;
    switch (rank) {
      case 1:
        position = RankPosition.first;
      case 2:
        position = RankPosition.second;
      case 3:
        position = RankPosition.third;
      default:
        position = RankPosition.other;
    }

    confettiController.play();
    emit(position);
  }

  /// Stops the confetti animation.
  void stopConfetti() {
    confettiController.stop();
    emit(null);
  }

  @override
  Future<void> close() {
    confettiController.dispose();
    return super.close();
  }
}
