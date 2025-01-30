import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/screens/GameScreen.dart';
import 'package:word_game/screens/HomeScreen.dart';
import 'package:word_game/widgets/lobby_widgets/player_list.dart';
import 'package:word_game/widgets/lobby_widgets/room_info.dart';
import 'package:word_game/widgets/lobby_widgets/start_button.dart';
import 'package:word_game/widgets/lobby_widgets/lobby_header.dart';

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
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is GameStartFailed || state is GameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state is GameStartFailed
                  ? state.errorMessage
                  : (state as GameError).message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildHeaderLobby(context, isLeader, roomId, playerName),
                      SizedBox(height: 20),
                      buildRoomInfo(context, roomId),
                      SizedBox(height: 20),
                      Expanded(
                        child: state is InLobby
                            ? buildPlayerList(context, state.players)
                            : Center(child: CircularProgressIndicator()),
                      ),
                      if (isLeader && state is InLobby)
                        buildStartButton(context, roomId),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
