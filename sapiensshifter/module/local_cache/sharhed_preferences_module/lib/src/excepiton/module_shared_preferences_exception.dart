import 'package:core/core.dart';

final class ModuleSharedPreferencesException extends BaseExceptionInterface {
  ModuleSharedPreferencesException(String code,
      {Map<String, String>? optionArgs, StackTrace? stackTrace})
      : super(
            _getMessage(code, optionArgs: optionArgs) ??
                _defaultFirebaseErrorMessage,
            code: code,
            stackTrace: stackTrace ?? StackTrace.current);

  /// A static getter that returns a default error message when a localized one is not found.
  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  /// Retrieves the localized error message for a given local cache error code.
  /// - [code]: The specific Firestore error code.
  /// - [optionArgs]: Optional arguments for dynamic message formatting.
  static String? _getMessage(String code, {Map<String, String>? optionArgs}) {
    String localizationBasePath = "all_exception.local_cache_exception";
    return LocalizationOperationMixin.getMessage('$localizationBasePath.$code',
        optionArgs: optionArgs);
  }
}
