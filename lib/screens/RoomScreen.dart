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
            }
          },
          builder: (context, state) {
            if (state is RoomCreating) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).roomScreenTitle),
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
                    // Kullanıcı adı girişi
                    TextField(
                      controller: playerNameController,
                      decoration: InputDecoration(
                        labelText: S.of(context).enterPlayerName,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Oda kimliği girişi
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
                        context.read<GameBloc>().add(CreateRoom(
                              // Change CreateRoom to JoinRoom
                              roomId: roomId,
                              playerName: playerName,
                            ));
                      },
                      child: Text(S.of(context).joinRoomButton),
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
