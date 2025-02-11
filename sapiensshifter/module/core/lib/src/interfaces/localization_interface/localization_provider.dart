/// Çeviri sağlayıcı arayüzü (Easy Localization veya başka sistemlerle uyumlu)
abstract class LocalizationProvider {
  static LocalizationProvider? _instance;

  static void setInstance(LocalizationProvider provider) {
    _instance = provider;
  }

  static LocalizationProvider? get instance => _instance ??=
      throw UnimplementedError('LocalizationProvider is instance empty.');

  String? getMessage(String key, {Map<String, dynamic>? optionArgs});
}
