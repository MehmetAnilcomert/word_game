import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/wordle/view/mixin/wordle_view_mixin.dart';
import 'package:word_game/feature/wordle/view/wordle_create_view.dart';
import 'package:word_game/feature/wordle/view_model/wordle_state.dart';
import 'package:word_game/feature/wordle/view_model/wordle_view_model.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/product/utility/padding/product_padding.dart';
import 'package:word_game/product/utility/screen_size_extension.dart';

part 'widget/wordle_grid.dart';
part 'widget/wordle_header.dart';
part 'widget/wordle_input.dart';

/// [WordleView] is the main screen for the Wordle game.
class WordleView extends StatefulWidget {
  /// Initializes a [WordleView].
  const WordleView({required this.wordLength, required this.lang, super.key});

  /// The length of the word (e.g., 4, 5, 6).
  final int wordLength;

  /// The language code (e.g., 'en', 'tr').
  final String lang;

  @override
  State<WordleView> createState() => _WordleViewState();
}

class _WordleViewState extends BaseState<WordleView>
    with WordleViewMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    setupAnimations(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WordleViewModel(
          initialLang: widget.lang,
          initialWordLength: widget.wordLength,
        )..startNewGame();
      },
      child: BlocListener<WordleViewModel, WordleState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!.tr()),
                backgroundColor: context.colorScheme.error,
              ),
            );
          }
          if (state.lastEarnedScore > 0) {
            playScoreAnimation();
          }
          if (state.isError) {
            playErrorAnimation();
          }
        },
        listenWhen: (previous, current) =>
            previous.isError != current.isError ||
            previous.lastEarnedScore != current.lastEarnedScore ||
            previous.errorMessage != current.errorMessage,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: BoxDecoration(
              gradient: context.backgroundGradient,
            ),
            child: SafeArea(
              child: Padding(
                padding: const ProductPadding.allNormal(),
                child: Column(
                  children: [
                    _WordleHeader(
                      scoreScaleAnimation: scoreScaleAnimation,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Wordle',
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _WordleGrid(
                      shakeAnimation: errorShakeAnimation,
                      scaleAnimation: errorScaleAnimation,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<WordleViewModel, WordleState>(
                      builder: (context, state) {
                        if (state.status != WordleGameStatus.playing) {
                          return Column(
                            children: [
                              Text(
                                (state.status == WordleGameStatus.won
                                    ? LocaleKeys.winMessage.tr()
                                    : LocaleKeys.loseMessage.tr()),
                                style: context.textTheme.headlineMedium?.copyWith(
                                  color: context.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${LocaleKeys.targetWordLabel.tr()} ${state.targetWord}',
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colorScheme.onSurface
                                      .withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (context) => const WordleCreateView(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.colorScheme.surface,
                                  foregroundColor: context.colorScheme.primary,
                                ),
                                child: Text(LocaleKeys.playAgain.tr()),
                              ),
                            ],
                          );
                        }
                        return _WordleInput(
                          wordLength: state.wordLength,
                          onSubmitted: (word) {
                            context.read<WordleViewModel>().submitGuess(word);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
