import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/constant/color_constant.dart';

final class SapiensTheme {
  SapiensTheme._();
  static final _instance = SapiensTheme._();
  static SapiensTheme get instance => _instance;

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Geist',
        colorScheme: _lightColorScheme,
      );

  /// Custom Light Color Scheme
  final ColorScheme _lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: ColorConstant.primaryColor,
    onPrimary: Colors.black,
    primaryContainer: ColorConstant.primaryColor,
    secondary: ColorConstant.primaryColor,
    onSecondary: Colors.black,
    error: Color(0xffba1a1a),
    onError: Colors.white,
    surface: ColorConstant.backgroundColor,
    onSurface: Colors.black,
  );
}
