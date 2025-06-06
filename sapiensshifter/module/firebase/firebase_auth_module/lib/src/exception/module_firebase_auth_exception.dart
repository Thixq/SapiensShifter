import 'package:core/core.dart';

class ModuleFirebaseAuthException extends IBaseException
    with LocalizationOperationMixin {
  ModuleFirebaseAuthException({required String code, StackTrace? stackTrace})
      : super(
          _getErrorMessage(code) ?? _defaultFirebaseErrorMessage,
          code: code,
          stackTrace: stackTrace ?? StackTrace.current,
        );

  static String? _getErrorMessage(String code) {
    final String localzationBasePath = 'all_exception.firebase_auth_exception';

    final reCode = code.replaceAll('-', '_');

    return LocalizationOperationMixin.getMessage(
        '$localzationBasePath.$reCode');
  }

  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  @override
  String toString() =>
      '$runtimeType: Error Code: $code - Error Message: $message';
}
