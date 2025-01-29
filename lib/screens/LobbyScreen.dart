import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/GameScreen.dart';
import 'package:word_game/widgets/lobby_widgets/player_list.dart';
import 'package:word_game/widgets/lobby_widgets/start_button.dart';

class LobbyScreen extends StatelessWidget {
  final String roomId;
  final String playerName;
  final bool isLeader;

  LobbyScreen({
    required this.roomId,
    required this.playerName,
    required this.isLeader,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameInProgress) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(
                roomId: roomId,
                playerName: playerName,
              ),
            ),
          );
        }
      },
      child: Scaffold(
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).lobbyTitle,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${S.of(context).roomId}: $roomId',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        if (state is InLobby) {
                          return buildPlayerList(context, state.players);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  if (isLeader) buildStartButton(context, roomId),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
