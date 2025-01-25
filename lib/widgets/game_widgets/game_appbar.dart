import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/timerBloc/TimerBloc.dart';
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'package:word_game/generated/l10n.dart';

Widget buildGameAppBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        String title = state is TimerRunning && state.isNearingEnd
            ? S.of(context).hurryUp
            : S.of(context).gameScreenTitle;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: state is TimerRunning && state.isNearingEnd
                    ? Colors.red
                    : Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    ),
  );
}
