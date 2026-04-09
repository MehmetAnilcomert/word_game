import 'package:flutter/material.dart';
import 'package:word_game/feature/lobby/view/lobby_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';

mixin LobbyViewMixin on State<LobbyView> {
  @override
  void initState() {
    super.initState();
  }

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
