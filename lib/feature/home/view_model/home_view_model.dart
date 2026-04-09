import 'package:word_game/product/state/base/base_view_model.dart';

/// State class for [HomeViewModel].
class HomeState {
  /// Initializes [HomeState].
  const HomeState();
}

/// [HomeViewModel] manages the logic for the home screen.
class HomeViewModel extends BaseViewModel<HomeState> {
  /// Initializes [HomeViewModel] with [HomeState].
  HomeViewModel() : super(const HomeState());
}
