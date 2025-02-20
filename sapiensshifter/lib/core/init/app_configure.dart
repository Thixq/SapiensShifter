import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_dependency.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class AppConfigure {
  AppConfigure._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();
    LocalizationProvider.setInstance(EasyLocal());
    await AppDependency.setup();
  }
}

class EasyLocal extends LocalizationProvider {
  @override
  String? getMessage(String key, {Map<String, String>? optionArgs}) {
    return key.tr(namedArgs: optionArgs);
  }
}
