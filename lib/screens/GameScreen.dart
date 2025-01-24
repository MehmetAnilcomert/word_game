import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
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
    return BlocProvider(
      create: (context) => GameBloc(FirebaseFirestore.instance)
        ..add(StartGame(roomId))
        ..add(ListenToGameUpdates(roomId)),
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameOver) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(data: state.data),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GameInProgress) {
            final letters = List<String>.from(state.data['letters']);
            final scores = Map<String, int>.from(state.data['scores'] ?? {});
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
                  child: Column(
                    children: [
                      buildGameAppBar(context),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              buildLetters(letters, context),
                              SizedBox(height: 20),
                              buildScoreBoard(scores, context),
                              buildWordInput(context, roomId, playerName),
                              buildEndGameButton(context, roomId),
                            ],
                          ),
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
}
