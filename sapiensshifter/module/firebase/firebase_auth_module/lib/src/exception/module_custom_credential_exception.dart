import 'package:core/core.dart';

final class ModuleCustomCredentialException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  ModuleCustomCredentialException(
      {required String code,
      Map<String, dynamic>? optionArgs,
      StackTrace? stackTrace})
      : super(_getErrorMessage(code, optionArgs) ?? defaultFirebaseErrorMessage,
            code: code, stackTrace: stackTrace ?? StackTrace.current);

  static String? _getErrorMessage(
      String code, Map<String, dynamic>? optionArgs) {
    final String basePath = 'all_exception.social_credential_exception';

    final reCode = code.replaceAll('-', '_');

    return LocalizationOperationMixin.getErrorMessage(
      '$basePath.$reCode',
      optionArgs: optionArgs,
    );
  }

  static String get defaultFirebaseErrorMessage => 'Unknown Error';

  @override
  String toString() =>
      '$runtimeType: Error Code: $code - Error Message: $message';
}
