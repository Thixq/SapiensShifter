import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_dependency.dart';
import 'package:sapiensshifter/core/localization/easy_localization_provider.dart';
import 'package:sapiensshifter/core/logging/logging_manager.dart';
import 'package:sapiensshifter/core/notification/firebase_notification_handler.dart';
import 'package:sapiensshifter/core/notification/notification_service.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

final class ProductConfigure {
  ProductConfigure._();
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreferencesOperation.instance.initialize();
    LoggingManager.init();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();

    // Notificaton setup
    final notificationService = NotificationService();
    await notificationService.initialize();
    final firebaseHandler = FirebaseNotificationHandler(notificationService);
    await firebaseHandler.initialize();
    // debugPrint(await FirebaseMessaging.instance.getToken());

    // Dependency Injection
    await AppDependency.setup();

    // To activate the localizations within modules that use the core package.
    LocalizationProvider.setInstance(EasyLocalizatonProvider());
  }
}
