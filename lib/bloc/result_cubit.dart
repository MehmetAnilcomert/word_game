// result_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:confetti/confetti.dart';

enum RankPosition { first, second, third, other }

class ResultCubit extends Cubit<RankPosition?> {
  final ConfettiController confettiController;

  ResultCubit()
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
