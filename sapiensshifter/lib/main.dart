// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/preview_table_card.dart';
import 'package:sapiensshifter/product/component/sapi_counter_dialog.dart';
import 'package:sapiensshifter/product/export_dependency_package/component_export_package.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) => MaterialApp(
        theme: SapiensTheme.instance.lightTheme,
        home: Thix(),
      ),
    );
  }
}

class Thix extends StatelessWidget {
  Thix({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.popupManager.showLoader(
            barrierDismissible: true,
            widgetBuilder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: context.border.normalBorderRadius),
              child: SapiCounterDialog(
                titleName: 'Masa 12',
                buttonText: 'Onayla',
                onPressed: (val) {
                  debugPrint('$val');
                },
              ),
            ),
          );
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
