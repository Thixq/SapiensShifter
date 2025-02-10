abstract class BaseExceptionInterface implements Exception {
  BaseExceptionInterface(this.code, this.message, [this.stackTrace]);
  String message;
  final String code;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Error Run Type:$runtimeType, Error Code: $code, Error Message: $message.';
  }
}
