import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_configure.dart';
import 'package:sapiensshifter/core/localization/localization.dart';
import 'package:sapiensshifter/core/logging/zone_manager.dart';
import 'package:sapiensshifter/core/theme/appliaction_theme.dart';
import 'package:sapiensshifter/feature/splash/view/splash_view.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

void main() async {
  await AppConfigure().initialize();

  await ZoneManager.runAppInZone(
    () async {
      runApp(
        LanguageManager(
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) => MaterialApp(
        theme: SapiensTheme.instance.lightTheme,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        home: SplashView(),
      ),
    );
  }
}
