import 'package:flutter/material.dart';
import 'package:word_game/feature/wordle/view/wordle_view.dart';

/// [WordleViewMixin] provides common functionalities for the [WordleView] state.
mixin WordleViewMixin on State<WordleView> {
  late final TextEditingController playerNameController;
  late final AnimationController scoreAnimationController;
  late final Animation<double> scoreScaleAnimation;

  @override
  void initState() {
    super.initState();
    playerNameController = TextEditingController();
  }

  /// Sets up the score animation.
  void setupScoreAnimation(TickerProvider vsync) {
    scoreAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 500),
    );
    scoreScaleAnimation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: scoreAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  /// Plays the score animation.
  void playScoreAnimation() {
    scoreAnimationController.forward().then((_) {
      scoreAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    playerNameController.dispose();
    scoreAnimationController.dispose();
    super.dispose();
  }

  /// Formats the [seconds] into a readable string in 'MM:SS' format.
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secondsRemaining = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secondsRemaining';
  }
}
