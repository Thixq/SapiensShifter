import 'package:core/core.dart' show LocalizationProvider;

class MockLocalizationProvider extends LocalizationProvider {
  @override
  String? getMessage(String key, {Map<String, String>? optionArgs}) {
    return 'ModuleFirestoreException';
  }
}
