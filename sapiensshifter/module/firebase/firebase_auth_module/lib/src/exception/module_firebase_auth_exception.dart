import 'package:core/core.dart';

class ModuleFirebaseAuthException extends BaseExceptionInterface {
  ModuleFirebaseAuthException(String code, [StackTrace? stackTrace])
      : super(
            code, _getMessageFromCode(code), stackTrace ?? StackTrace.current);

  static String _getMessageFromCode(String code) {
    if (code == 'oneError') {
      return 'TwoException oneError, TwoException oneError';
    } else if (code == 'twoError') {
      return 'TwoException twoError, TwoException twoError';
    }
    return 'Unknown error';
  }

  @override
  String toString() => 'FirebaseAuthException: Code: $code - Message: $message';
}
