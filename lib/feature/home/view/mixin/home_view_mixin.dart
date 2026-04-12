import 'package:flutter/material.dart';
import 'package:word_game/feature/home/view/home_view.dart';
import 'package:word_game/product/state/admin_state.dart';

/// Mixin for [HomeView] to handle state-related logic.
mixin HomeViewMixin on State<HomeView> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  @override
  void initState() {
    super.initState();
    // Setup UI logic if needed
  }

  void onTitleTapped() {
    final now = DateTime.now();
    if (_lastTapTime == null ||
        now.difference(_lastTapTime!) > const Duration(seconds: 1)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTapTime = now;

    if (_tapCount == 5) {
      _tapCount = 0;
      AdminState.toggleAdmin();
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              AdminState.isAdmin
                  ? 'Admin Modu Açıldı!'
                  : 'Admin Modu Kapatıldı!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
  }
}
