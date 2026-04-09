import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:word_game/feature/game/view_model/game_view_model.dart';
import 'package:word_game/feature/game/view_model/game_view_model_event.dart';
import 'package:word_game/feature/game/view_model/game_view_model_state.dart' as game_state;

import 'package:word_game/feature/home/view/home_view.dart';
import 'package:word_game/feature/room/view/mixin/room_view_mixin.dart';
import 'package:word_game/feature/room/view_model/room_view_model.dart';
import 'package:word_game/feature/lobby/view/lobby_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
import 'package:word_game/product/utility/constants/enums/locales.dart';
import 'package:word_game/product/state/base/base_state.dart';

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
            MaterialPageRoute<dynamic>(builder: (context) => const HomeView()),
            (route) => false,
          );
          return false;
        },
        child: BlocConsumer<GameViewModel, game_state.GameViewModelState>(
          listener: (context, state) {
            if (state is game_state.RoomCreated || state is game_state.RoomJoined) {
              final roomViewModel = context.read<RoomViewModel>().state;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (context) => LobbyView(
                    roomId: roomViewModel.roomID,
                    playerName: roomViewModel.playerName,
                    isLeader: widget.isCreateRoom,
                  ),
                ),
              );
            } else if (state is game_state.RoomCreationFailed || state is game_state.RoomJoinFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state is game_state.RoomCreationFailed
                      ? state.errorMessage
                      : (state as game_state.RoomJoinFailed).errorMessage),
                  backgroundColor: context.colorScheme.error,
                ),
              );
            }
          },
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
