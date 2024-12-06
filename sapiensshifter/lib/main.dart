// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SapiensTheme.instance.lightTheme,
      home: const Thix(),
    );
  }
}

class Thix extends StatelessWidget {
  const Thix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
