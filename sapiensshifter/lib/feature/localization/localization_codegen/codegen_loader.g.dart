// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> tr = {
  "price_symbol": "₺",
  "confirm": "Onayla",
  "drop_down": {
    "drop_down_default": "Seçiniz",
    "drop_down_extra": "Extra Seçiniz"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr": tr};
}
