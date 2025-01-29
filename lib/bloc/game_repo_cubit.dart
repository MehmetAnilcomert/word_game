import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:word_game/repositories/game_repository.dart';

class GameRepositoryState {
  final GameRepository repository;
  GameRepositoryState(this.repository);
}

class GameRepositoryCubit extends Cubit<GameRepositoryState> {
  GameRepositoryCubit()
      : super(GameRepositoryState(
            GameRepository(firestore: FirebaseFirestore.instance)));
}
