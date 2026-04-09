import 'package:flutter/material.dart';
import 'package:word_game/feature/room/view/room_view.dart';

/// Mixin for [RoomView] to handle navigation and state-related logic.
mixin RoomViewMixin on State<RoomView> {
  @override
  void initState() {
    super.initState();
  }

  /// Navigates back to the previous screen.
  void onNavigateBack() {
    Navigator.of(context).pop();
  }
}