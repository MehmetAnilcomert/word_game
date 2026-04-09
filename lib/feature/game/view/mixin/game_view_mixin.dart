import 'package:flutter/material.dart';
import 'package:word_game/feature/game/view/game_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/timerBloc/TimerBloc.dart';
import 'package:word_game/bloc/timerBloc/TimerEvent.dart';

mixin GameViewMixin on State<GameView> {
  @override
  void initState() {
    super.initState();
  }

  void startTimer(BuildContext context, int endTime) {
    context.read<TimerBloc>().add(StartTimer(endTime));
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
