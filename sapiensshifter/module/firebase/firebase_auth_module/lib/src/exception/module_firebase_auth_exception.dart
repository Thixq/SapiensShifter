// Importing the core package that includes the necessary dependencies:
// BaseExceptionInterface and LocalizationOperationMixin.
import 'package:core/core.dart';

/// A class representing custom Firebase Authentication exceptions.
///
/// This exception extends the BaseExceptionInterface to provide a standard error structure
/// and utilizes LocalizationOperationMixin to fetch localized error messages based on error codes.
class ModuleFirebaseAuthException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  /// Constructor for creating a [ModuleFirebaseAuthException] instance.
  ///
  /// [code] is a required parameter representing the error code.
  /// [stackTrace] is optional; if not provided, the current stack trace is used.
  ModuleFirebaseAuthException({required String code, StackTrace? stackTrace})
      : super(
          // Attempt to fetch a localized error message using the provided error code.
          // If no localized message is found, use the default error message.
          _getErrorMessage(code) ?? _defaultFirebaseErrorMessage,
          code: code,
          // Use the provided stack trace, or default to the current stack trace.
          stackTrace: stackTrace ?? StackTrace.current,
        );

  /// A helper static method that tries to retrieve a localized error message.
  ///
  /// [code] is the error code used to fetch the corresponding localized message.
  ///
  /// Returns a localized message if available; otherwise, it returns null.
  static String? _getErrorMessage(String code) {
    // Define the base path for Firebase authentication exception localization keys.
    final String localzationBasePath = 'all_exception.firebase_auth_exception';

    // Replace hyphens with underscores in the error code for consistency with localization keys.
    final reCode = code.replaceAll('-', '_');

    // Construct the full localization key and fetch the message using the mixin's static method.
    return LocalizationOperationMixin.getMessage(
        '$localzationBasePath.$reCode');
  }

  /// A static getter that provides a default error message when a localized one is not found.
  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  /// Overrides the default toString method to provide a detailed string representation of the exception.
  ///
  /// The representation includes the runtime type, error code, and error message.
  @override
  String toString() =>
      '$runtimeType: Error Code: $code - Error Message: $message';
}
