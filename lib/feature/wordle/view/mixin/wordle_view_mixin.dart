import 'package:flutter/material.dart';
import 'package:word_game/feature/wordle/view/wordle_view.dart';

/// [WordleViewMixin] provides common functionalities for the [WordleView] state.
mixin WordleViewMixin on State<WordleView> {
  late final TextEditingController playerNameController;
  late final AnimationController scoreAnimationController;
  late final Animation<double> scoreScaleAnimation;

  late final AnimationController errorAnimationController;
  late final Animation<double> errorShakeAnimation;
  late final Animation<double> errorScaleAnimation;

  @override
  void initState() {
    super.initState();
    playerNameController = TextEditingController();
  }

  /// Sets up the score animation.
  void setupAnimations(TickerProvider vsync) {
    // Score Animation
    scoreAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 500),
    );
    scoreScaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: scoreAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    // Error Animation
    errorAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );

    errorShakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(errorAnimationController);

    errorScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
    ]).animate(errorAnimationController);
  }

  /// Plays the score animation.
  void playScoreAnimation() {
    scoreAnimationController.forward().then((_) {
      scoreAnimationController.reverse();
    });
  }

  /// Plays the error animation.
  void playErrorAnimation() {
    errorAnimationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    playerNameController.dispose();
    scoreAnimationController.dispose();
    errorAnimationController.dispose();
    super.dispose();
  }

  /// Formats the [seconds] into a readable string in 'MM:SS' format.
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secondsRemaining = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secondsRemaining';
  }
}
