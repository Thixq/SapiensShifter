// Importing the core package, which contains necessary dependencies including
// the BaseExceptionInterface and LocalizationOperationMixin.
import 'package:core/core.dart';

/// A final class representing a custom exception for module-specific credential errors.
///
/// This exception extends the BaseExceptionInterface to standardize error handling
/// and uses the LocalizationOperationMixin to retrieve localized error messages.
final class ModuleCustomCredentialException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  /// Constructor for creating a [ModuleCustomCredentialException] instance.
  ///
  /// [code]: A required string that represents the error code.
  /// [optionArgs]: An optional map of arguments used for localizing the error message.
  /// [stackTrace]: An optional StackTrace. If not provided, the current stack trace is used.
  ModuleCustomCredentialException({
    required String code,
    Map<String, dynamic>? optionArgs,
    StackTrace? stackTrace,
  }) : super(
          // Fetch a localized error message based on the provided [code] and [optionArgs].
          // If no localized message is found, use the default error message.
          _getErrorMessage(code, optionArgs) ?? _defaultFirebaseErrorMessage,
          code: code,
          // If a custom stack trace is not provided, default to the current stack trace.
          stackTrace: stackTrace ?? StackTrace.current,
        );

  /// A helper static method that attempts to fetch a localized error message.
  ///
  /// [code]: The specific error code to use for retrieving the message.
  /// [optionArgs]: Optional arguments for formatting the localized message.
  ///
  /// Returns the localized message as a String if available; otherwise, returns null.
  static String? _getErrorMessage(
      String code, Map<String, dynamic>? optionArgs) {
    // Define the base path for localization keys related to social credential exceptions.
    final String localzationBasePath =
        'all_exception.social_credential_exception';

    // Construct the full localization key by appending the specific [code] to the base path.
    // Then retrieve the localized message using the LocalizationOperationMixin.
    return LocalizationOperationMixin.getMessage(
      '$localzationBasePath.$code',
      optionArgs: optionArgs,
    );
  }

  /// A static getter that returns a default error message when a localized one is not found.
  static String get _defaultFirebaseErrorMessage => 'Unknown Error';

  /// Overrides the default toString method to provide a formatted string representation of the exception.
  ///
  /// The output includes the runtime type of the exception, the error code, and the error message.
  @override
  String toString() =>
      '$runtimeType: Error Code: $code - Error Message: $message';
}
