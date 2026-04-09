import 'package:flutter/material.dart';
import 'package:word_game/feature/room/view/room_view.dart';

mixin RoomViewMixin on State<RoomView> {
  @override
  void initState() {
    super.initState();
  }
  
  void onNavigateBack() {
    Navigator.of(context).pop();
  }
}
