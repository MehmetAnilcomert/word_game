import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/GameScreen.dart';
import 'package:word_game/screens/HomeScreen.dart';
import 'package:word_game/widgets/lobby_widgets/exit_dialog.dart';
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
        } else if (state is RoomCancelled || state is RoomLeaved) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else if (state is GameStartFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
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
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          bool shouldExit = await showExitDialog(context);
                          if (shouldExit) {
                            if (isLeader) {
                              context
                                  .read<GameBloc>()
                                  .add(CancelRoom(roomId: roomId));
                            } else {
                              context.read<GameBloc>().add(LeaveRoom(
                                  roomId: roomId, playerName: playerName));
                            }
                          }
                        },
                      ),
                      Expanded(
                        child: Text(
                          S.of(context).lobbyTitle,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 50), // To center the title text
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).roomId,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.97),
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '$roomId',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(4.0, 4.0),
                              blurRadius: 8.0,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ],
                          letterSpacing: 1.5,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        print(state);
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
