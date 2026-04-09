import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/game/view/game_view.dart';
import 'package:word_game/feature/game/view_model/timer_view_model.dart';
import 'package:word_game/feature/game/view_model/timer_view_model_event.dart';

/// [GameViewMixin] provides common functionalities for the [GameView] state.
mixin GameViewMixin on State<GameView> {
  @override
  void initState() {
    super.initState();
  }

  /// Starts the timer by providing the [endTime] (in ms)
  /// to the [TimerViewModel].
  void startTimer(BuildContext context, int endTime) {
    context.read<TimerViewModel>().add(StartTimerEvent(endTime));
  }

  /// Formats the [seconds] into a readable string in 'MM:SS' format.
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secondsRemaining = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secondsRemaining';
  }
}
