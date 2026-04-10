import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/wordle/view/mixin/wordle_view_mixin.dart';
import 'package:word_game/feature/wordle/view_model/wordle_state.dart';
import 'package:word_game/feature/wordle/view_model/wordle_view_model.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/product_localization.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/product/utility/padding/product_padding.dart';
import 'package:word_game/product/utility/screen_size_extension.dart';

part 'widget/wordle_grid.dart';
part 'widget/wordle_header.dart';
part 'widget/wordle_keyboard.dart';
part 'widget/wordle_settings_dialog.dart';

/// [WordleView] is the main screen for the Wordle game.
class WordleView extends StatefulWidget {
  /// Initializes a [WordleView].
  const WordleView({super.key});

  @override
  State<WordleView> createState() => _WordleViewState();
}

class _WordleViewState extends BaseState<WordleView>
    with WordleViewMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    setupScoreAnimation(this);
  }

  @override
  Widget build(BuildContext context) {
    final initialLocale = ProductLocalization.getCurrentLanguageCode(context);
    return BlocProvider(
      create: (context) {
        return WordleViewModel(
          initialLang: initialLocale,
          initialWordLength: 5,
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
        },
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
                      showInfo: () => _showHowToPlay(context),
                      scoreScaleAnimation: scoreScaleAnimation,
                    ),
                    const SizedBox(height: 20),
                    const _WordleGrid(),
                    const Spacer(),
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
                                  color: context.colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${LocaleKeys.targetWordLabel.tr()} ${state.targetWord}',
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colorScheme.onPrimary
                                      .withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _showSettings(context),
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

  void _showHowToPlay(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocaleKeys.wordleInfoTitle.tr()),
        content: Text(LocaleKeys.wordleInfoContent.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(LocaleKeys.confirm.tr()),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: context.read<WordleViewModel>(),
        child: const _WordleSettingsDialog(),
      ),
    );
  }
}
