import 'package:core/src/interfaces/localization_interface/localization_provider.dart';

mixin class LocalizationOperationMixin {
  static String? getMessage(String key, {Map<String, String>? optionArgs}) {
    final instance = LocalizationProvider.instance;

    return instance?.getMessage(key, optionArgs: optionArgs);
  }
}
