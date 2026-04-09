import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:word_game/feature/game/view_model/game_view_model.dart';
import 'package:word_game/feature/game/view_model/game_view_model_event.dart';
import 'package:word_game/feature/game/view_model/game_view_model_state.dart';

import 'package:word_game/feature/home/view/home_view.dart';
import 'package:word_game/feature/lobby/view/mixin/lobby_view_mixin.dart';
import 'package:word_game/feature/game/view/game_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
import 'package:word_game/product/state/base/base_state.dart';

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
    return BlocProvider(
      create: (context) =>
          GameViewModel()..add(ListenToGameUpdatesEvent(widget.roomId)),
      child: BlocListener<GameViewModel, GameViewModelState>(
        listener: (context, state) {
          if (state is GameInProgress) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(
                builder: (context) => GameView(
                  roomId: widget.roomId,
                  playerName: widget.playerName,
                ),
              ),
            );
          } else if (state is RoomCancelled || state is RoomLeaved) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (context) => const HomeView()),
            );
          } else if (state is InLobby && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: context.colorScheme.error,
              ),
            );
          }
        },
        child: BlocBuilder<GameViewModel, GameViewModelState>(
          builder: (context, state) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: context.backgroundGradient,
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
                                context.read<GameViewModel>().add(
                                    CancelRoomEvent(roomId: widget.roomId));
                              } else {
                                context.read<GameViewModel>().add(
                                    LeaveRoomEvent(
                                        roomId: widget.roomId,
                                        playerName: widget.playerName));
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
                              : const Center(
                                  child: CircularProgressIndicator()),
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
      ),
    );
  }
}
