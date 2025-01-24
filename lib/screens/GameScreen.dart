// Game Screen
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/ResultScreen.dart';

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
              appBar: AppBar(
                title: Text(S.of(context).gameScreenTitle),
                centerTitle: true,
                leading: Container(),
                backgroundColor: Colors.blue,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                child: Column(
                  children: [
                    Text(
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      "${S.of(context).lettersLabel}: ${letters.join(", ")}",
                    ),
                    Expanded(
                      child: ListView(
                        children: scores.entries
                            .map((e) => ListTile(
                                  title: Text(e.key),
                                  trailing: Text(e.value.toString()),
                                ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        onSubmitted: (word) {
                          context
                              .read<GameBloc>()
                              .add(SubmitWord(roomId, playerName, word));
                        },
                        decoration:
                            InputDecoration(labelText: S.of(context).enterWord),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<GameBloc>().add(EndGame(roomId));
                      },
                      child: Text(S.of(context).endGameButton),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
