// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/component/sapi_button.dart';
import 'package:sapiensshifter/product/component/sapi_text_field.dart';
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
  const Thix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SapiTextField(
                isPassword: true,
                hintText: 'Password',
              ),
              SizedBox(
                height: 12,
              ),
              SapiButton(
                buttonText: 'buttonText',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
