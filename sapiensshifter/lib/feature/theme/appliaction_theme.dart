import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/constant/color_constant.dart';

final class SapiensTheme {
  SapiensTheme._();
  static final _instance = SapiensTheme._();
  static SapiensTheme get instance => _instance;

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: "Geist",
        colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstant.primaryColor, contrastLevel: 1),
      );
}
