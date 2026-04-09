import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseViewModel<T> extends Cubit<T> {
  BaseViewModel(super.initialState);

  // Common functionality for ViewModels (e.g. loading tracking, error handling)
}
