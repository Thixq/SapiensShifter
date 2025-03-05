import 'package:core/core.dart';

class TestLocalizationProvider extends LocalizationProvider {
  @override
  String? getMessage(String key, {Map<String, dynamic>? optionArgs}) {
    if (key == 'all_exception.local_cache_exception.not_found_key') {
      return 'not_found_key';
    } else if (key ==
        'all_exception.local_cache_exception.un_supported_value') {
      return 'un_supported_value';
    } else if (key == 'all_exception.local_cache_exception.expected_type') {
      return 'expected_type';
    } else {
      return 'Unknown Key';
    }
  }
}
