/// Çeviri sağlayıcı arayüzü (Easy Localization veya başka sistemlerle uyumlu)
abstract class LocalizationProvider {
  static LocalizationProvider? _instance;

  static void setInstance(LocalizationProvider provider) {
    _instance = provider;
  }

  static LocalizationProvider? get instance {
    if (_instance == null) {
      throw Exception('boş amk');
    }
    return _instance;
  }

  String? getMessage(String key);
}
