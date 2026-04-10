import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:word_game/feature/game_selection/view/game_selection_view.dart';
import 'package:word_game/feature/home/view/mixin/home_view_mixin.dart';
import 'package:word_game/feature/room/view/room_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/product_localization.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/product/utility/constants/enums/locales.dart';
import 'package:word_game/product/utility/padding/product_padding.dart';

part 'widget/home_action_buttons.dart';
part 'widget/home_appbar.dart';
part 'widget/home_title.dart';

/// The main landing screen of the application.
class HomeView extends StatefulWidget {
  /// Initializes a [HomeView].
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: context.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const _HomeAppBar(),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const ProductPadding.allNormal(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const _HomeTitle(),
                          const SizedBox(height: 50),
                          _HomeActionButtons(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
