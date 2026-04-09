import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/game/view/view_model/game_view_model.dart';

/// A widget that initializes bloc state management for the application.
class StateInitialize extends StatelessWidget {
  /// Creates an instance of [StateInitialize] with the given [child].
  const StateInitialize({
    required this.child,
    super.key,
  });

  /// The child widget to be wrapped with state management providers.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameViewModel>(
          create: (context) => GameViewModel(),
        ),
      ],
      child: child,
    );
  }
}
