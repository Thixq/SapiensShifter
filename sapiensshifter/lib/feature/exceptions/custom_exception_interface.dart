abstract class CustomException implements Exception {
  CustomException(this.message, [this.stackTrace]);
  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}
