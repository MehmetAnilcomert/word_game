import 'package:flutter_bloc/flutter_bloc.dart';

/// [BaseViewModel] provides a standard base class for all view models,
/// inherited from [Cubit].
abstract class BaseViewModel<T> extends Cubit<T> {
  /// Initializes [BaseViewModel] with the [initialState].
  BaseViewModel(super.initialState);
}