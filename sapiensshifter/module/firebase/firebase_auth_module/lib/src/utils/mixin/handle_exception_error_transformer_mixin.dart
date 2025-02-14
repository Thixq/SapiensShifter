// Importing the core package which provides common utilities and exception interfaces.
import 'package:core/core.dart';
// Importing Firebase Auth package to handle authentication related exceptions.
import 'package:firebase_auth/firebase_auth.dart';
// Importing the custom exception definitions.
import '../../exception/exception.dart';

/// Mixin that provides error transformation methods for handling exceptions.
///
/// This mixin offers a standardized way to convert Firebase authentication exceptions
/// into a custom exception format by wrapping them in a [ModuleFirebaseAuthException].
mixin HandleExceptionErrorTransformerMixin {
  /// Transforms a [FirebaseAuthException] into a custom [BaseExceptionInterface].
  ///
  /// This method takes a [FirebaseAuthException] and an optional [stackTrace],
  /// then returns a [ModuleFirebaseAuthException] that encapsulates the error code and stack trace.
  ///
  /// - [exception]: The [FirebaseAuthException] that occurred.
  /// - [stackTrace]: An optional stack trace, defaulting to null if not provided.
  ///
  /// Returns a [ModuleFirebaseAuthException] representing the transformed error.
  BaseExceptionInterface handleFirebaseAuthException(
    FirebaseAuthException exception, [
    StackTrace? stackTrace,
  ]) {
    // Wrap the FirebaseAuthException in a ModuleFirebaseAuthException with the exception's code.
    return ModuleFirebaseAuthException(
      code: exception.code,
      stackTrace: stackTrace,
    );
  }
}
