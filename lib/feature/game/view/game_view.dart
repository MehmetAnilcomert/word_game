import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:word_game/feature/game/view/mixin/game_view_mixin.dart';
import 'package:word_game/feature/game/view/view_model/game_view_model.dart';
import 'package:word_game/feature/game/view/view_model/game_view_model_event.dart';
import 'package:word_game/feature/game/view/view_model/game_view_model_state.dart' as game_state;
import 'package:word_game/feature/game/view/view_model/timer_view_model.dart';
import 'package:word_game/feature/game/view/view_model/timer_view_model_event.dart';
import 'package:word_game/feature/game/view/view_model/timer_view_model_state.dart' as timer_state;
import 'package:word_game/feature/result/view/result_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
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
          create: (context) => TimerViewModel(),
        ),
        BlocProvider(
          create: (context) => GameViewModel()
            ..add(StartGameEvent(roomId: widget.roomId))
            ..add(ListenToGameUpdatesEvent(widget.roomId)),
        )
      ],
      child: BlocConsumer<GameViewModel, game_state.GameViewModelState>(
        listener: (context, state) {
          if (state is game_state.GameInProgress && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: context.colorScheme.error,
                duration: const Duration(seconds: 2),
              ),
            );
          }
          if (state is game_state.GameOver) {
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
          if (state is game_state.GameInProgress) {
            final endTime = state.data['endTime'] as int;
            startTimer(context, endTime);
          }
        },
        builder: (context, state) {
          if (state is game_state.GameInProgress) {
            final letters = List<String>.from(state.data['letters']);
            final scores = Map<String, int>.from(state.data['scores'] ?? {});
            final usedWords =
                Map<String, List<dynamic>>.from(state.data['usedWords'] ?? {});
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: context.backgroundGradient,
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const _GameAppBar(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      Positioned(
                        top: 15,
                        right: 10,
                        child: BlocBuilder<TimerViewModel, timer_state.TimerViewModelState>(
                          builder: (context, timerState) {
                            if (timerState is timer_state.TimerRunning) {
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
                                        ? context.colorScheme.error.withOpacity(0.8)
                                        : context.colorScheme.scaffoldBackgroundColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: context.appColors.cardShadow,
                                        blurRadius: 4,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    formatTime(timerState.remainingTime),
                                    style: TextStyle(
                                      color: context.colorScheme.onSurface,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            } else if (timerState is timer_state.TimerEnded) {
                              context
                                  .read<GameViewModel>()
                                  .add(EndGameEvent(widget.roomId));
                            }
                            return const SizedBox.shrink();
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
                gradient: context.backgroundGradient,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      context.colorScheme.onPrimary),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
