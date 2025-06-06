abstract class IBaseException implements Exception {
  String message;

  final String? code;

  final StackTrace? stackTrace;

  IBaseException(this.message, {this.code, this.stackTrace});

  @override
  String toString() {
    return 'Error Run Type: $runtimeType, Error Code: $code, Error Message: $message.';
  }
}
