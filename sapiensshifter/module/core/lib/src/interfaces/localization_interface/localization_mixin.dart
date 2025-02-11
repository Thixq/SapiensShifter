import 'package:core/src/interfaces/localization_interface/localization_provider.dart';

mixin LocalizationOperationMixin {
  static String? getErrorMessage(String error,
      {Map<String, dynamic>? optionArgs}) {
    final instance = LocalizationProvider.instance;
    return instance?.getMessage(error, optionArgs: optionArgs);
  }
}
