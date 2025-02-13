import 'package:core/core.dart';

final class ModuleCustomCredentialException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  ModuleCustomCredentialException(
      {required String code,
      Map<String, dynamic>? optionArgs,
      StackTrace? stackTrace})
      : super(
            _getErrorMessage(code, optionArgs) ?? _defaultFirebaseErrorMessage,
            code: code,
            stackTrace: stackTrace ?? StackTrace.current);

  static String? _getErrorMessage(
      String code, Map<String, dynamic>? optionArgs) {
    final String basePath = 'all_exception.social_credential_exception';

    return LocalizationOperationMixin.getMessage(
      '$basePath.$code',
      optionArgs: optionArgs,
    );
  }

  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  @override
  String toString() =>
      '$runtimeType: Error Code: $code - Error Message: $message';
}
