import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_dependency.dart';
import 'package:sapiensshifter/core/localization/easy_localization_provider.dart';
import 'package:sapiensshifter/core/logging/logging_manager.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class AppConfigure {
  AppConfigure._();
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();

    // Dependency Injection
    await AppDependency.setup();

    LoggingManager.init();

    // To activate the localizations within modules that use the core package.
    LocalizationProvider.setInstance(EasyLocalizatonProvider());
  }
}
