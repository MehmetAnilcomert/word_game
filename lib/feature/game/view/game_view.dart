import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/bloc/timerBloc/TimerBloc.dart';
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'package:word_game/feature/game/view/mixin/game_view_mixin.dart';
import 'package:word_game/feature/result/view/result_view.dart';
import 'package:word_game/product/state/base/base_state.dart';

part 'widget/game_appbar.dart';
part 'widget/game_letters.dart';
part 'widget/game_scoreboard.dart';
part 'widget/game_word_input.dart';
part 'widget/game_end_button.dart';

class GameView extends StatefulWidget {
  final String roomId;
  final String playerName;

  const GameView({super.key, required this.roomId, required this.playerName});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends BaseState<GameView> with GameViewMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TimerBloc(),
        ),
        BlocProvider(
          create: (context) =>
              GameBloc(context, timerBloc: context.read<TimerBloc>())
                ..add(StartGame(roomId: widget.roomId))
                ..add(ListenToGameUpdates(widget.roomId)),
        )
      ],
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameInProgress && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
          if (state is GameOver) {
            // Navigate to result screen when the game is over
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultView(
                  data: state.data,
                  currentUser: widget.playerName,
                ),
              ),
            );
          }
          if (state is GameInProgress) {
            final endTime = state.data['endTime'] as int;
            startTimer(context, endTime);
          }
        },
        builder: (context, state) {
          if (state is GameInProgress) {
            final letters = List<String>.from(state.data['letters']);
            final scores = Map<String, int>.from(state.data['scores'] ?? {});
            final usedWords =
                Map<String, List<dynamic>>.from(state.data['usedWords'] ?? {});
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[300]!, Colors.purple[300]!],
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const _GameAppBar(),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  _GameLetters(letters: letters),
                                  const SizedBox(height: 20),
                                  _GameScoreboard(
                                      scores: scores, usedWords: usedWords),
                                  _GameWordInput(
                                      roomId: widget.roomId,
                                      playerName: widget.playerName),
                                  _GameEndButton(roomId: widget.roomId),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Timer indicator (top right corner)
                      Positioned(
                        top: 15,
                        right: 10,
                        child: BlocBuilder<TimerBloc, TimerState>(
                          builder: (context, timerState) {
                            if (timerState is TimerRunning) {
                              return AnimatedOpacity(
                                opacity: timerState.isFlashing
                                    ? (timerState.remainingTime % 2 == 0
                                        ? 1.0
                                        : 0.5)
                                    : 1.0,
                                duration: const Duration(milliseconds: 500),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: timerState.remainingTime <= 10
                                        ? Colors.red.withOpacity(0.8)
                                        : Colors.black.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    formatTime(timerState.remainingTime),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            } else if (timerState is TimerEnded) {
                              context
                                  .read<GameBloc>()
                                  .add(EndGame(widget.roomId));
                            }
                            return const SizedBox.shrink(); // If timer is not active, return empty widget
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[300]!, Colors.purple[300]!],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
