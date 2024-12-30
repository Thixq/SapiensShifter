import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/localization/localization.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/component/message_info_list_tile.dart';
import 'package:sapiensshifter/product/component/order_card.dart';
import 'package:sapiensshifter/product/component/preview_order_card.dart';
import 'package:sapiensshifter/product/component/preview_product_card.dart';
import 'package:sapiensshifter/product/component/preview_table_card.dart';
import 'package:sapiensshifter/product/component/sapi_button.dart';
import 'package:sapiensshifter/product/component/sapi_custom_drop_down.dart';
import 'package:sapiensshifter/product/component/sapi_text_field.dart';
import 'package:sapiensshifter/product/component/segments_button.dart';
import 'package:sapiensshifter/product/component/week_card.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/models/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/nav_bar_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    LanguageManager(
      child: const MyApp(),
    ),
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
        home: const Thix(),
      ),
    );
  }
}

class Thix extends StatelessWidget {
  const Thix({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SapiSegmentButton()),
    );
  }
}
