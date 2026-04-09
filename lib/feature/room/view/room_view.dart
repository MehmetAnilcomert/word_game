import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';

import 'package:word_game/feature/home/view/home_view.dart';
import 'package:word_game/feature/room/view/mixin/room_view_mixin.dart';
import 'package:word_game/feature/room/view_model/room_view_model.dart';
import 'package:word_game/product/model/lang_options.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/screens/LobbyScreen.dart';

part 'widget/room_header.dart';
part 'widget/room_number_picker.dart';
part 'widget/room_form_content.dart';
part 'widget/room_action_button.dart';

class RoomView extends StatefulWidget {
  final bool isCreateRoom;

  const RoomView({super.key, required this.isCreateRoom});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends BaseState<RoomView> with RoomViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoomViewModel(),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false,
          );
          return false;
        },
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            if (state is RoomCreated || state is RoomJoined) {
              final roomViewModel = context.read<RoomViewModel>().state;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LobbyScreen(
                    roomId: roomViewModel.roomID,
                    playerName: roomViewModel.playerName,
                    isLeader: widget.isCreateRoom,
                  ),
                ),
              );
            } else if (state is RoomCreationFailed || state is RoomJoinFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state is RoomCreationFailed
                      ? state.errorMessage
                      : (state as RoomJoinFailed).errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
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
                        _RoomHeader(isCreateRoom: widget.isCreateRoom),
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: _RoomFormContent(isCreateRoom: widget.isCreateRoom),
                            ),
                          ),
                        ),
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
