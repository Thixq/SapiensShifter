import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';

class EasyLocalizatonProvider extends LocalizationProvider {
  @override
  String? getMessage(String key, {Map<String, String>? optionArgs}) {
    return key.tr(namedArgs: optionArgs);
  }
}
