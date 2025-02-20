/// Localization provider interface (compatible with Localization systems).
abstract class LocalizationProvider {
  /// Private static variable to hold the singleton instance of the LocalizationProvider.
  static LocalizationProvider? _instance;

  /// Sets the singleton instance of the LocalizationProvider.
  ///
  /// [provider]: The instance to set as the active LocalizationProvider.
  static void setInstance(LocalizationProvider provider) {
    _instance = provider;
  }

  /// Gets the singleton instance of the LocalizationProvider.
  ///
  /// If the instance is not set, it throws an [UnimplementedError].
  /// This ensures that an instance is always available when requested.
  static LocalizationProvider? get instance => _instance ??=
      throw UnimplementedError('LocalizationProvider is instance empty.');

  /// Retrieves a localized message corresponding to the given [key].
  ///
  /// [key]: The identifier for the localized message.
  /// [optionArgs]: An optional map of arguments used for formatting the message.
  ///
  /// Returns the localized message as a [String] if found; otherwise, it returns null.
  String? getMessage(String key, {Map<String, String>? optionArgs});
}
