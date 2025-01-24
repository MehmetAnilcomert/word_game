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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(FirebaseFirestore.instance),
      child: WillPopScope(
        // Use WillPopScope to intercept the back button press
        onWillPop: () async {
          // Navigate to the home screen and clear the stack
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false, // Remove all other routes
          );
          return false;
        },
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            if (state is RoomCreated) {
              // Navigate to the game screen when a room is successfully created
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(roomId: state.roomId),
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
                  icon: Icon(Icons.arrow_back), // Back button in AppBar
                  onPressed: () {
                    // Navigate to the home screen and clear the stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: S.of(context).enterRoomId,
                        ),
                        onSubmitted: (roomId) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameScreen(roomId: roomId),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Trigger the CreateRoom event
                        context.read<GameBloc>().add(CreateRoom());
                      },
                      child: Text(S.of(context).createRoomButton),
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
