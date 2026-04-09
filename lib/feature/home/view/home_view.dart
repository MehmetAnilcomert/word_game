import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:country_flags/country_flags.dart';

import 'package:word_game/feature/home/view/mixin/home_view_mixin.dart';
import 'package:word_game/product/state/base/base_state.dart';
import 'package:word_game/product/utility/padding/product_padding.dart';
import 'package:word_game/screens/RoomScreen.dart'; // Temporarily to old route

part 'widget/home_appbar.dart';
part 'widget/home_action_buttons.dart';
part 'widget/home_title.dart';

class HomeView extends StatefulWidget {
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[300]!, Colors.purple[300]!],
          ),
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
