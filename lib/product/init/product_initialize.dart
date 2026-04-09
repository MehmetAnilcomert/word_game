import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_game/product/state/container/product_state_container.dart';

@immutable

/// A class responsible for initializing product-level configurations before the app starts.
final class ProductInitialize {
  /// Starts the application by initializing necessary configurations.
  Future<void> startApplication() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initialize();
  }

  /// Initializes necessary configurations for the product.
  Future<void> _initialize() async {
    await EasyLocalization.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await Firebase.initializeApp();

    /// Initialize GetIt
    ProductContainer.setUp();
  }
}
