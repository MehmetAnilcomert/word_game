import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:word_game/feature/home/view/home_view.dart';
import 'package:word_game/feature/result/view/mixin/result_view_mixin.dart';
import 'package:word_game/feature/result/view_model/result_view_model.dart';
import 'package:word_game/feature/room/view/room_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/product/utility/padding/product_padding.dart';
import 'package:word_game/product/utility/result_util.dart';

part 'widget/result_build_animation.dart';
part 'widget/result_button_widgets.dart';
part 'widget/result_score_table.dart';
part 'widget/result_winner.dart';

/// The screen displaying the final scores and winner after a game.
class ResultView extends StatefulWidget {
  /// Initializes a [ResultView].
  const ResultView({required this.data, required this.currentUser, super.key});

  /// The final score data as a list of player names and scores.
  final List<MapEntry<String, int>> data;

  /// The name of the current player.
  final String currentUser;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends BaseState<ResultView> with ResultViewMixin {
  late final ResultViewModel _resultViewModel;

  @override
  void initState() {
    super.initState();
    _resultViewModel = ResultViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rank = ResultUtil.findRank(widget.data, widget.currentUser);
      _resultViewModel.startConfetti(rank);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _resultViewModel,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: context.backgroundGradient,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const ProductPadding.allNormal(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocaleKeys.resultScreenTitle.tr(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _ResultWinner(sortedScores: widget.data),
                      const SizedBox(height: 20),
                      _ResultScoreTable(sortedScores: widget.data),
                      const Spacer(),
                      _ResultButtons(),
                    ],
                  ),
                ),
                BlocBuilder<ResultViewModel, RankPosition?>(
                  builder: (context, position) {
                    if (position == null) return const SizedBox.shrink();
                    return _ResultConfetti(
                      position: position,
                      controller: _resultViewModel.confettiController,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
