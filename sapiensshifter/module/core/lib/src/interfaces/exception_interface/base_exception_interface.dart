/// An abstract base class for custom exceptions.
/// Implements Dart's built-in Exception interface.
abstract class IBaseException implements Exception {
  /// A descriptive error message detailing what went wrong.
  String message;

  /// An optional error code to further categorize the error.
  final String? code;

  /// An optional stack trace that provides debugging information.
  final StackTrace? stackTrace;

  /// Constructor for creating an instance of BaseExceptionInterface.
  ///
  /// [message] is required to describe the error.
  /// [code] and [stackTrace] are optional parameters.
  IBaseException(this.message, {this.code, this.stackTrace});

  /// Overrides the default toString method to provide a detailed string representation
  /// of the exception, including the runtime type, error code, and error message.
  @override
  String toString() {
    return 'Error Run Type: $runtimeType, Error Code: $code, Error Message: $message.';
  }
}
