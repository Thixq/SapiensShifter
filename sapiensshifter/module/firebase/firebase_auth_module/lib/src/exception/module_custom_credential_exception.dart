import 'package:core/core.dart';

final class ModuleCustomCredentialException extends IBaseException
    with LocalizationOperationMixin {
  ModuleCustomCredentialException({
    required String code,
    Map<String, String>? optionArgs,
    StackTrace? stackTrace,
  }) : super(
          _getErrorMessage(code, optionArgs) ?? _defaultFirebaseErrorMessage,
          code: code,
          stackTrace: stackTrace ?? StackTrace.current,
        );

  static String? _getErrorMessage(
      String code, Map<String, String>? optionArgs) {
    final String localzationBasePath =
        'all_exception.social_credential_exception';

    return LocalizationOperationMixin.getMessage(
      '$localzationBasePath.$code',
      optionArgs: optionArgs,
    );
  }

  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  @override
  String toString() =>
      '$runtimeType - Error Code: $code - Error Message: $message';
}
