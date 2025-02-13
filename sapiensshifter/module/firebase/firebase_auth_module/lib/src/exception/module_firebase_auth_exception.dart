import 'package:core/core.dart';

class ModuleFirebaseAuthException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  ModuleFirebaseAuthException({required String code, StackTrace? stackTrace})
      : super(_getErrorMessage(code) ?? _defaultFirebaseErrorMessage,
            code: code, stackTrace: stackTrace ?? StackTrace.current);

  static String? _getErrorMessage(String code) {
    final String basePath = 'all_exception.firebase_auth_exception';

    final reCode = code.replaceAll('-', '_');

    return LocalizationOperationMixin.getMessage('$basePath.$reCode');
  }

  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  @override
  String toString() =>
      '$runtimeType: Error Code: $code - Error Message: $message';
}
