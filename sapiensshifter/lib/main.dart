import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/localization/localization.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/choice_chip_list.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

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
    return Scaffold(
      body: Center(child: DynamicChoiceChipScreen()),
    );
  }
}

class DynamicChoiceChipScreen extends StatelessWidget {
  DynamicChoiceChipScreen({super.key});

  final Map<String, double>? options = {
    'Single Shot': 0,
    'Double Shot': 0,
    'Three Shot': 17.99,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic ChoiceChip Example'),
      ),
      body: ChoiceChipList<double>(
        options: options,
        onSelected: (value) {
          print('Value: $value');
        },
      ),
    );
  }
}
