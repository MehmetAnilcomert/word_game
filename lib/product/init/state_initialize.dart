import 'package:get_it/get_it.dart';
import 'package:word_game/product/service/game_repository.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<GameService>(
    () => GameService(firestore: FirebaseFirestore.instance),
  );
}
