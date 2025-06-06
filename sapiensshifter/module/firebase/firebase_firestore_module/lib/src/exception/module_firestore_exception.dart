import 'package:core/core.dart';

/// Exception class for handling Firestore-related errors.
/// Uses localization to fetch appropriate error messages.
class ModuleFirestoreException extends IBaseException
    with LocalizationOperationMixin {
  ModuleFirestoreException(String code,
      {Map<String, String>? optionArgs, StackTrace? stackTrace})
      : super(
            _getMessage(code, optionArgs: optionArgs) ??
                _defaultFirebaseErrorMessage,
            code: code,
            stackTrace: stackTrace ?? StackTrace.current);

  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  static String? _getMessage(String code, {Map<String, String>? optionArgs}) {
    String localizationBasePath = "all_exception.firebase_firestore_exception";
    return LocalizationOperationMixin.getMessage('$localizationBasePath.$code',
        optionArgs: optionArgs);
  }
}
