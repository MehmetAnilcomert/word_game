import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/GameScreen.dart';
import 'package:word_game/screens/HomeScreen.dart';
import 'package:word_game/widgets/room_widgets/action_button.dart';
import 'package:word_game/widgets/room_widgets/build_number.dart';
import 'package:word_game/widgets/room_widgets/header.dart';
import 'package:word_game/widgets/room_widgets/input_widget.dart';

class RoomScreen extends StatelessWidget {
  final TextEditingController playerNameController = TextEditingController();
  final TextEditingController roomIdController = TextEditingController();
  late int endTime = 1;
  late int playerNumber = 4;
  final bool isCreateRoom;

  RoomScreen({required this.isCreateRoom});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(
                  roomId: roomIdController.text,
                  playerName: playerNameController.text,
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
                      buildHeader(context, isCreateRoom),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: _buildContent(context, state, isCreateRoom),
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
    );
  }

  Widget _buildContent(
      BuildContext context, GameState state, bool isCreateRoom) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildInputField(
              controller: playerNameController,
              label: S.of(context).enterPlayerName,
              icon: Icons.person,
            ),
            SizedBox(height: 20),
            buildInputField(
              controller: roomIdController,
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
                        onChanged: (value) {
                          // Seçilen değeri kullan
                          print('Seçilen değer: $value');
                          endTime = value.toInt();
                        },
                      ),
                      SizedBox(height: 20),
                      buildNumberSelector(
                        label: S.of(context).enterPlayerNumber,
                        icon: Icons.person,
                        minValue: 2,
                        maxValue: 10,
                        onChanged: (value) {
                          // Seçilen değeri kullan
                          print('Seçilen oyuncu sayısı: $value');
                          playerNumber = value.toInt();
                        },
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 40),
            buildActionButton(context, state, isCreateRoom,
                playerNameController, roomIdController, endTime),
          ],
        ),
      ),
    );
  }
}
