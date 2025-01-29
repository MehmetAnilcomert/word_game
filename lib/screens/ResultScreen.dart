import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/utils/result_util.dart';
import 'package:word_game/widgets/result_widgets/build_animation.dart';
import 'package:word_game/widgets/result_widgets/button_widgets.dart';
import 'package:word_game/widgets/result_widgets/score_table.dart';
import 'package:word_game/widgets/result_widgets/winner.dart';
import 'package:word_game/bloc/result_cubit.dart';

class ResultScreen extends StatelessWidget {
  final List<MapEntry<String, int>> data;
  final String currentUser;

  ResultScreen({required this.data, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResultCubit(),
      child: Builder(
        builder: (context) {
          final resultCubit = context.read<ResultCubit>();
          final rank = findRank(data, currentUser);

          // Start the animation when screen is built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            resultCubit.startConfetti(rank);
          });

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
                    // Main content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            S.of(context).resultScreenTitle,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          buildWinnerCard(data, context),
                          SizedBox(height: 20),
                          buildScoreTable(data, context),
                          Spacer(),
                          buildButtons(context),
                        ],
                      ),
                    ),
                    // Confetti animation
                    BlocBuilder<ResultCubit, RankPosition?>(
                      builder: (context, position) {
                        if (position == null) return const SizedBox.shrink();
                        return buildConfetti(
                          position,
                          resultCubit.confettiController,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
