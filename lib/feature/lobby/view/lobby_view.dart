import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';

import 'package:word_game/feature/home/view/home_view.dart';
import 'package:word_game/feature/lobby/view/mixin/lobby_view_mixin.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/screens/GameScreen.dart';

part 'widget/lobby_header.dart';
part 'widget/lobby_room_info.dart';
part 'widget/lobby_player_list.dart';
part 'widget/lobby_start_button.dart';

class LobbyView extends StatefulWidget {
  final String roomId;
  final String playerName;
  final bool isLeader;

  const LobbyView({
    super.key,
    required this.roomId,
    required this.playerName,
    required this.isLeader,
  });

  @override
  State<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends BaseState<LobbyView> with LobbyViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameInProgress) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(
                roomId: widget.roomId,
                playerName: widget.playerName,
              ),
            ),
          );
        } else if (state is RoomCancelled || state is RoomLeaved) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
          );
        } else if (state is InLobby && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
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
                      _LobbyHeader(
                        isLeader: widget.isLeader,
                        roomId: widget.roomId,
                        playerName: widget.playerName,
                        onExit: () async {
                          final shouldExit = await showExitDialog();
                          if (shouldExit) {
                            if (widget.isLeader) {
                              context.read<GameBloc>().add(CancelRoom(roomId: widget.roomId));
                            } else {
                              context.read<GameBloc>().add(LeaveRoom(roomId: widget.roomId, playerName: widget.playerName));
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      _RoomInfo(roomId: widget.roomId),
                      const SizedBox(height: 20),
                      Expanded(
                        child: state is InLobby
                            ? _PlayerList(players: state.players)
                            : const Center(child: CircularProgressIndicator()),
                      ),
                      if (widget.isLeader && state is InLobby)
                        _StartButton(roomId: widget.roomId),
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
