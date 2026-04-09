import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:word_game/feature/lobby/view/lobby_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';

/// Mixin for [LobbyView] to handle state-related logic and dialogs.
mixin LobbyViewMixin on State<LobbyView> {
  @override
  void initState() {
    super.initState();
  }

  /// Shows a confirmation dialog when the player tries to exit the lobby.
  Future<bool> showExitDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(LocaleKeys.exitLobbyTitle.tr()),
              content: Text(LocaleKeys.exitLobbyMessage.tr()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(LocaleKeys.cancel.tr()),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(LocaleKeys.confirm.tr()),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
