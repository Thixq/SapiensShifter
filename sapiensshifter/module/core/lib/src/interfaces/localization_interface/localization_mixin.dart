// Importing the LocalizationProvider from the core package.
// This provider is responsible for fetching localized messages.
import 'package:core/src/interfaces/localization_interface/localization_provider.dart';

/// A mixin that provides localization operations.
///
/// This mixin offers a static method to retrieve localized messages
/// based on a provided key and optional parameters.
mixin LocalizationOperationMixin {
  /// Retrieves a localized message for the given [key].
  ///
  /// [key]: The identifier used to fetch the corresponding localized message.
  /// [optionArgs]: An optional map of arguments that may be used to format the message.
  ///
  /// Returns the localized message as a [String] if available, otherwise returns null.
  static String? getMessage(String key, {Map<String, dynamic>? optionArgs}) {
    // Retrieve the singleton instance of LocalizationProvider.
    // The provider handles accessing localization data throughout the app.
    final instance = LocalizationProvider.instance;

    // Call the getMessage method on the LocalizationProvider instance,
    // passing the key and optional arguments.
    // If the instance is null, this expression returns null.
    return instance?.getMessage(key, optionArgs: optionArgs);
  }
}
