part of '../result_view.dart';

class _ResultConfetti extends StatelessWidget {
  final RankPosition position;
  final ConfettiController controller;

  const _ResultConfetti({
    required this.position,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    switch (position) {
      case RankPosition.first:
        return Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirection: 3.14159 / 2,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
            colors: const [
              Colors.amber,
              Colors.yellow,
              Colors.orangeAccent,
            ],
          ),
        );

      case RankPosition.second:
        return Align(
          alignment: Alignment.centerRight,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirection: 3.14159,
            maxBlastForce: 4,
            minBlastForce: 2,
            emissionFrequency: 0.04,
            numberOfParticles: 40,
            gravity: 0.1,
            colors: const [
              Colors.grey,
              Colors.white70,
              Colors.blueGrey,
            ],
          ),
        );

      case RankPosition.third:
        return Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirectionality: BlastDirectionality.explosive,
            maxBlastForce: 3,
            minBlastForce: 1,
            emissionFrequency: 0.03,
            numberOfParticles: 30,
            gravity: 0.2,
            colors: const [
              Colors.brown,
              Colors.orange,
              Colors.deepOrange,
            ],
          ),
        );

      case RankPosition.other:
        return Align(
          alignment: Alignment.bottomCenter,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirection: -3.14159 / 2,
            maxBlastForce: 2,
            minBlastForce: 1,
            emissionFrequency: 0.02,
            numberOfParticles: 20,
            gravity: 0.1,
            colors: const [
              Colors.blue,
              Colors.green,
              Colors.purple,
            ],
          ),
        );
    }
  }
}
