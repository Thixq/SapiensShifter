import 'package:core/core.dart';

/// Exception class for handling Firestore-related errors.
/// Uses localization to fetch appropriate error messages.
class ModuleFirestoreException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  /// Constructor to initialize the Firestore exception.
  /// - [code]: The error code identifying the specific Firestore issue.
  /// - [optionArgs]: Optional arguments for localization message formatting.
  /// - [stackTrace]: The stack trace at the point of error occurrence.
  ModuleFirestoreException(String code,
      {Map<String, String>? optionArgs, StackTrace? stackTrace})
      : super(
            _getMessage(code, optionArgs: optionArgs) ??
                _defaultFirebaseErrorMessage,
            code: code,
            stackTrace: stackTrace ?? StackTrace.current);

  /// A static getter that returns a default error message when a localized one is not found.
  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  /// Retrieves the localized error message for a given Firestore error code.
  /// - [code]: The specific Firestore error code.
  /// - [optionArgs]: Optional arguments for dynamic message formatting.
  static String? _getMessage(String code, {Map<String, String>? optionArgs}) {
    String localizationBasePath = "all_exception.firebase_firestore_exception";
    return LocalizationOperationMixin.getMessage('$localizationBasePath.$code',
        optionArgs: optionArgs);
  }
}
