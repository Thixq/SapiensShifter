import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/localization/localization.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/preview_order_card.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/order_info_bottom_sheet.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';

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
      body: Center(child: Blabla()),
    );
  }
}

class Blabla extends StatelessWidget {
  const Blabla({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('a'),
      onPressed: () {
        // ignore: inference_failure_on_function_invocation
        showModalBottomSheet<Widget>(
          context: context,
          builder: (BuildContext context) {
            return OrderInfoBottomSheet(
              tableModel: TableModel(
                tableName: 'O3',
                orderList: [
                  OrderModel(
                    orderName: 'Cortado',
                    imagePath: 'https://coffee.alexflipnote.dev/random',
                    price: 123,
                  ),
                  OrderModel(
                    orderName: 'Caffee Latte',
                    imagePath: 'https://coffee.alexflipnote.dev/random',
                    price: 200,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
