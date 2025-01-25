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
            state is TimerRunning && state.isNearingEnd
                ? Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                    ],
                  ) // Hurry up Widget
                : Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ), // Normal Widget style
                  ),
          ],
        );
      },
    ),
  );
}
