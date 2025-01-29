import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart' as GameEvent;
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/bloc/timerBloc/TimerBloc.dart';
import 'package:word_game/bloc/timerBloc/TimerEvent.dart' as TimerEvent;
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'package:word_game/repositories/game_repository.dart';
import 'package:word_game/screens/ResultScreen.dart';
import 'package:word_game/widgets/game_widgets/end_button.dart';
import 'package:word_game/widgets/game_widgets/game_appbar.dart';
import 'package:word_game/widgets/game_widgets/letters.dart';
import 'package:word_game/widgets/game_widgets/scoreboard.dart';
import 'package:word_game/widgets/game_widgets/word_input.dart';

class GameScreen extends StatelessWidget {
  final String roomId;
  final String playerName;

  GameScreen({required this.roomId, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TimerBloc(),
        ),
        BlocProvider(
          create: (context) => GameBloc(context.read<GameRepository>(),
              timerBloc: context.read<TimerBloc>())
            ..add(GameEvent.StartGame(roomId))
            ..add(GameEvent.ListenToGameUpdates(roomId)),
        )
      ],
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is WordSubmissionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
          if (state is GameOver) {
            // Navigate to result screen when the game is over
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(data: state.data),
              ),
            );
          }
          if (state is GameInProgress) {
            final endTime = state.data['endTime'] as int;
            context.read<TimerBloc>().add(TimerEvent.StartTimer(endTime));
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
                          buildGameAppBar(context),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  buildLetters(letters, context),
                                  SizedBox(height: 20),
                                  buildScoreBoard(scores, usedWords, context),
                                  buildWordInput(context, roomId, playerName),
                                  buildEndGameButton(context, roomId),
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
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    _formatTime(timerState.remainingTime),
                                    style: TextStyle(
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
                                  .add(GameEvent.EndGame(roomId));
                            }
                            return SizedBox
                                .shrink(); // If timer is not active, return empty widget
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
              child: Center(
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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
