import 'package:flutter/material.dart';
import 'package:word_game/widgets/home_widgets/action_buttons.dart';
import 'package:word_game/widgets/home_widgets/app_title.dart';
import 'package:word_game/widgets/home_widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              buildAppBar(context),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildAppTitle(context),
                          SizedBox(height: 50),
                          buildActionButtons(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
