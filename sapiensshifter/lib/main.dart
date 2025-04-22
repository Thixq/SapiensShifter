import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure.dart';
import 'package:sapiensshifter/core/localization/localization.dart';
import 'package:sapiensshifter/core/logging/zone_manager.dart';
import 'package:sapiensshifter/core/routing/routing_manager.dart';
import 'package:sapiensshifter/core/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart'
    show BuildContextEasyLocalizationExtension, Sizer;

void main() async {
  ZoneManager.runAppInZone(
    () async {
      await ProductConfigure.initialize();
      runApp(
        LanguageManager(
          child: Sizer(
            builder: (_, __, ___) => const _MyApp(),
          ),
        ),
      );
    },
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp();
  static final RoutingManager _routing = RoutingManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sapiens Shifter',
      routerConfig: _routing.config(
        navigatorObservers: () => [routeObserver],
      ),
      theme: SapiensTheme.instance.lightTheme,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
