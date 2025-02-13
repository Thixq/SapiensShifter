import 'package:core/src/interfaces/localization_interface/localization_provider.dart';

mixin LocalizationOperationMixin {
  static String? getMessage(String key, {Map<String, dynamic>? optionArgs}) {
    final instance = LocalizationProvider.instance;
    return instance?.getMessage(key, optionArgs: optionArgs);
  }
}
