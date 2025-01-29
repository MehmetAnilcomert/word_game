import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:confetti/confetti.dart';
import 'package:word_game/widgets/result_widgets/button_widgets.dart';
import 'package:word_game/widgets/result_widgets/score_table.dart';
import 'package:word_game/widgets/result_widgets/winner.dart';

class ResultScreen extends StatefulWidget {
  final List<MapEntry<String, int>> data;
  ResultScreen({required this.data});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortedScores = widget.data;

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
          child: Padding(
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
                buildWinnerCard(sortedScores, context),
                SizedBox(height: 20),
                buildScoreTable(sortedScores, context),
                Spacer(),
                buildButtons(context),
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: -pi / 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
