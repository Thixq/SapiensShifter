import 'package:core/src/interfaces/localization_interface/localization_interface.dart';

mixin LocalizationOperationMixin {
  static String? getErrorMessage(String code) {
    final instance = LocalizationProvider.instance;
    return instance?.getMessage(code);
  }
}
