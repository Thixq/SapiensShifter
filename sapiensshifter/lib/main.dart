// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/custom_drop_down.dart';
import 'package:sapiensshifter/product/component/sapi_button.dart';
import 'package:sapiensshifter/product/component/sapi_text_field.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

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
  const Thix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropDown(),
            SizedBox(
              height: 16,
            ),
            SapiTextField(),
            SizedBox(
              height: 16,
            ),
            SapiButton(
              buttonText: 'Press',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
