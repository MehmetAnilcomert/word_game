import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/game/view/game_view.dart';
import 'package:word_game/feature/game/view/view_model/timer_view_model.dart';
import 'package:word_game/feature/game/view/view_model/timer_view_model_event.dart';

mixin GameViewMixin on State<GameView> {
  @override
  void initState() {
    super.initState();
  }

  void startTimer(BuildContext context, int endTime) {
    context.read<TimerViewModel>().add(StartTimerEvent(endTime));
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
