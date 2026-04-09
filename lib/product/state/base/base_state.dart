import 'dart:async';
import 'package:flutter/material.dart';

/// [BaseState] provides common state management utilities for [StatefulWidget]s.
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// Executes the [action] if the widget is still mounted.
  ///
  /// This is used to safely use [BuildContext] after async gaps.
  Future<void> safeOperation(FutureOr<void> action) async {
    if (!mounted) return;
    if (action is Future) {
      await action;
    }
  }

  /// Checks if the widget is mounted before executing the callback.
  void ifMounted(VoidCallback callback) {
    if (mounted) callback();
  }
}