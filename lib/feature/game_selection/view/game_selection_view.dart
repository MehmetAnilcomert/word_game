import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:word_game/feature/room/view/room_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/product/utility/padding/product_padding.dart';

part 'widget/game_selection_buttons.dart';

/// Screen to select which game mode to play.
class GameSelectionView extends StatefulWidget {
  /// Initializes a [GameSelectionView].
  const GameSelectionView({super.key});

  @override
  State<GameSelectionView> createState() => _GameSelectionViewState();
}

class _GameSelectionViewState extends BaseState<GameSelectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.wordGameTitle.tr()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: context.backgroundGradient,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: context.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const ProductPadding.allNormal(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.selectedWordArena.tr(),
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    const _GameSelectionButtons(),
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
