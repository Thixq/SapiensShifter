import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' show BuildContext, Locale;
import 'package:sapiensshifter/core/constant/string_constant.dart';
import 'package:sapiensshifter/core/localization/localization_codegen/codegen_loader.g.dart';

// ignore: lines_longer_than_80_chars
/// `LanguageManager` is responsible for managing language-related configurations.
final class LanguageManager extends EasyLocalization {
  /// Constructor to initialize `LanguageManager`.
  LanguageManager({
    required super.child,
    super.key,
  }) : super(
          saveLocale: true,
          supportedLocales: supportedLocalesLanguages,
          path: _translationPath,
          useOnlyLangCode: true,
          assetLoader: const CodegenLoader(),
        );

  /// The path where translation files are stored.
  static const String _translationPath = StringConstant.translationsPath;

  @override
  Locale? get fallbackLocale => const Locale('tr', 'TR');

  /// A list of supported locales in the app.
  static List<Locale> get supportedLocalesLanguages => [
        const Locale('tr', 'TR'),
      ];

  /// Method to update the language.
  static Future<void> updateLanguage({
    required BuildContext context,
    required Locale value,
  }) =>
      context.setLocale(value);

  /// Method to reset the language.
  static Future<void> setLocaleLanguage({
    required BuildContext context,
  }) =>
      context.resetLocale();
}
