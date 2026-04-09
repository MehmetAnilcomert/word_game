import 'package:confetti/confetti.dart';
import 'package:word_game/product/state/base/base_view_model.dart';

enum RankPosition { first, second, third, other }

class ResultViewModel extends BaseViewModel<RankPosition?> {
  final ConfettiController confettiController;

  ResultViewModel()
      : confettiController =
            ConfettiController(duration: const Duration(seconds: 5)),
        super(null);

  void startConfetti(int rank) {
    RankPosition position;
    switch (rank) {
      case 1:
        position = RankPosition.first;
        break;
      case 2:
        position = RankPosition.second;
        break;
      case 3:
        position = RankPosition.third;
        break;
      default:
        position = RankPosition.other;
        break;
    }

    confettiController.play();
    emit(position);
  }

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
