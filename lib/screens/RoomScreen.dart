import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/bloc/room_cubit.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/HomeScreen.dart';
import 'package:word_game/screens/LobbyScreen.dart';
import 'package:word_game/widgets/room_widgets/action_button.dart';
import 'package:word_game/widgets/room_widgets/build_number.dart';
import 'package:word_game/widgets/room_widgets/header.dart';
import 'package:word_game/widgets/room_widgets/input_widget.dart';

class RoomScreen extends StatelessWidget {
  final bool isCreateRoom;

  RoomScreen({required this.isCreateRoom});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoomCubit(),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
          return false;
        },
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            if (state is RoomCreated || state is RoomJoined) {
              final roomCubit = context.read<RoomCubit>().state;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LobbyScreen(
                      roomId: roomCubit.roomID,
                      playerName: roomCubit.playerName,
                      isLeader: isCreateRoom),
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
                        buildHeader(context, isCreateRoom),
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child:
                                  _buildContent(context, state, isCreateRoom),
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

  Widget _buildContent(
      BuildContext context, GameState state, bool isCreateRoom) {
    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, roomState) {
        return Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildInputField(
                  controller: context.read<RoomCubit>().playerNameController,
                  label: S.of(context).enterPlayerName,
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                buildInputField(
                  controller: context.read<RoomCubit>().roomIDController,
                  label: S.of(context).enterRoomId,
                  icon: Icons.meeting_room,
                ),
                SizedBox(height: 20),
                isCreateRoom
                    ? Column(
                        children: [
                          buildNumberSelector(
                            label: S.of(context).enterEndTime,
                            icon: Icons.timer,
                            minValue: 1,
                            maxValue: 10,
                            onChanged: (value) => context
                                .read<RoomCubit>()
                                .updateEndTime(value.toInt()),
                          ),
                          SizedBox(height: 20),
                          buildNumberSelector(
                            label: S.of(context).enterPlayerNumber,
                            icon: Icons.person,
                            minValue: 2,
                            maxValue: 10,
                            onChanged: (value) => context
                                .read<RoomCubit>()
                                .updatePlayerNumber(value.toInt()),
                          ),
                          SizedBox(height: 20),
                          buildNumberSelector(
                            label: S.of(context).enterLetterNumber,
                            icon: Icons.question_mark,
                            minValue: 6,
                            maxValue: 12,
                            onChanged: (value) => context
                                .read<RoomCubit>()
                                .updateLetterNumber(value.toInt()),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 40),
                buildActionButton(
                    context,
                    state,
                    isCreateRoom,
                    roomState.playerName,
                    roomState.roomID,
                    roomState.endTime,
                    roomState.playerNumber,
                    roomState.letterNumber),
              ],
            ),
          ),
        );
      },
    );
  }
}
