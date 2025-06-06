import 'package:core/core.dart';

final class ModuleSharedPreferencesException extends IBaseException {
  ModuleSharedPreferencesException(String code,
      {Map<String, String>? optionArgs, StackTrace? stackTrace})
      : super(
            _getMessage(code, optionArgs: optionArgs) ??
                _defaultFirebaseErrorMessage,
            code: code,
            stackTrace: stackTrace ?? StackTrace.current);

  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  static String? _getMessage(String code, {Map<String, String>? optionArgs}) {
    String localizationBasePath = "all_exception.local_cache_exception";
    return LocalizationOperationMixin.getMessage('$localizationBasePath.$code',
        optionArgs: optionArgs);
  }
}
