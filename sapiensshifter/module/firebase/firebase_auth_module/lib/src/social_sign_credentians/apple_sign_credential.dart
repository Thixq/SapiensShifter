// Importing the core package which contains common utilities and interfaces,
// such as CredentialStrategyInterface, CustomCredential, and handleAsyncOperation.
import 'package:core/core.dart';

// Importing the SignInWithApple package to handle Apple Sign-In functionality.
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Importing a custom exception class to handle credential-related errors.
import '../exception/module_custom_credential_exception.dart';

/// A final class that implements the Apple Sign-In credential strategy.
///
/// This class is responsible for obtaining credentials from Apple's Sign-In service
/// and converting them into a [CustomCredential] used by the application.
final class AppleSignCredential implements CredentialStrategyInterface {
  /// Asynchronously obtains the Apple Sign-In credentials and returns a [CustomCredential].
  ///
  /// The process includes calling Apple's sign-in flow, extracting the required tokens,
  /// and handling any potential errors by transforming them into a [ModuleCustomCredentialException].
  @override
  Future<CustomCredential> call() async {
    // handleAsyncOperation is used to manage asynchronous tasks and error handling.
    // It takes a function to execute and an error transformer function to handle exceptions.
    return handleAsyncOperation<CustomCredential, Exception>(
      () async {
        // Initiate the Apple Sign-In process by requesting the Apple ID credential.
        // The requested scopes include the user's email and full name.
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        // Construct and return a CustomCredential using the information obtained from Apple.
        // - providerId: Identifies the provider as 'apple'.
        // - accessToken: Uses the identityToken returned from Apple's credential.
        // - idToken: Uses the authorizationCode from Apple's credential.
        return CustomCredential(
          providerId: 'apple',
          accessToken: appleCredential.identityToken,
          idToken: appleCredential.authorizationCode,
        );
      },
      // The errorTransformer converts any caught errors into a ModuleCustomCredentialException.
      // This custom exception includes a specific error code and additional context.
      errorTransformer: (error, [stackTrace]) =>
          ModuleCustomCredentialException(
        code: 'failed_credential',
        optionArgs: {'social': 'Apple', 'error': error.toString()},
      ),
    );
  }
}
