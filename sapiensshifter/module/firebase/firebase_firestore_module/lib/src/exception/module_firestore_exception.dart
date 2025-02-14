import 'package:core/core.dart';

class ModuleFirestoreException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  ModuleFirestoreException(String code,
      {Map<String, dynamic>? optionArgs, StackTrace? stackTrace})
      : super('',
            code: _getMessage(code, optionArgs: optionArgs),
            stackTrace: stackTrace ?? StackTrace.current);
  static String get localizationBasePath =>
      "all_exception.firebase_firestore_exception";
  static String? _getMessage(String code, {Map<String, dynamic>? optionArgs}) {
    return LocalizationOperationMixin.getMessage('$localizationBasePath.$code',
        optionArgs: optionArgs);
  }
}
