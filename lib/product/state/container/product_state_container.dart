import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:word_game/product/service/firebase/firebase_game_service.dart';
import 'package:word_game/product/service/interface/i_game_service.dart';

/// A container class for managing product state instances.
///
/// This class utilizes the GetIt package for dependency injection.
final class ProductContainer {
  ProductContainer._();

  static final GetIt _getIt = GetIt.I;

  /// Sets up the necessary dependencies for the product state container.
  static void setUp() {
    _getIt.registerLazySingleton<IGameService>(
      () => FirebaseGameService(firestore: FirebaseFirestore.instance),
    );
  }

  /// Reads an instance of type [T] from the service locator then returns it.
  static T read<T extends Object>() => _getIt<T>();
}