import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/gameBloc/GameBloc.dart';
import 'package:word_game/bloc/gameBloc/GameEvent.dart';
import 'package:word_game/bloc/gameBloc/GameStates.dart';
import 'package:word_game/generated/l10n.dart';
import 'package:word_game/screens/GameScreen.dart';
import 'package:word_game/screens/HomeScreen.dart'; // Import your home screen

class RoomScreen extends StatelessWidget {
  final TextEditingController playerNameController = TextEditingController();
  final TextEditingController roomIdController = TextEditingController();
  final bool
      isCreateRoom; // Add a boolean to determine whether it's create or join

  RoomScreen({required this.isCreateRoom});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(FirebaseFirestore.instance),
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
            if (state is RoomCreated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(
                    roomId: roomIdController.text,
                    playerName: playerNameController.text,
                  ),
                ),
              );
            } else if (state is RoomCreationFailed) {
              // Handle RoomCreationFailed state
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is RoomJoined) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(
                    roomId: roomIdController.text,
                    playerName: playerNameController.text,
                  ),
                ),
              );
            } else if (state is RoomJoinFailed) {
              // Handle RoomJoinFailed state
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RoomCreating || state is RoomJoining) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: (isCreateRoom
                    ? Text(S.of(context).roomScreenTitleCreate)
                    : Text(S.of(context).roomScreenTitleJoin)),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: playerNameController,
                      decoration: InputDecoration(
                        labelText: S.of(context).enterPlayerName,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: roomIdController,
                      decoration: InputDecoration(
                        labelText: S.of(context).enterRoomId,
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        final playerName = playerNameController.text;
                        final roomId = roomIdController.text;

                        if (playerName.isEmpty || roomId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S.of(context).fillAllFields),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (isCreateRoom) {
                          context.read<GameBloc>().add(CreateRoom(
                                roomId: roomId,
                                playerName: playerName,
                              ));
                        } else {
                          context.read<GameBloc>().add(JoinRoom(
                                roomId: roomId,
                                playerName: playerName,
                              ));
                        }
                      },
                      child: Text(isCreateRoom
                          ? S.of(context).createRoomButton
                          : S.of(context).joinRoomButton),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
