// Importing the core package which provides essential utilities, such as CustomCredential,
// handleAsyncOperation, and the CredentialStrategyInterface.
import 'package:core/core.dart';

// Importing the Google Sign-In package to handle authentication via Google.
import 'package:google_sign_in/google_sign_in.dart';

// Importing a custom exception class for handling errors specific to credential operations.
import '../exception/module_custom_credential_exception.dart';

/// A final class implementing the Google Sign-In credential strategy.
///
/// This class obtains user credentials via Google Sign-In and transforms them into a
/// [CustomCredential] used throughout the application.
final class GoogleSignCredential implements CredentialStrategyInterface {
  /// Asynchronously obtains the Google Sign-In credentials and returns a [CustomCredential].
  ///
  /// If the user cancels the sign-in process or if an error occurs during authentication,
  /// a [ModuleCustomCredentialException] is thrown.
  @override
  Future<CustomCredential> call() async {
    // Use handleAsyncOperation to manage the asynchronous operation along with
    // centralized error handling. It executes the provided asynchronous function
    // and transforms any errors using the errorTransformer.
    return handleAsyncOperation<CustomCredential, Exception>(
      () async {
        // Initiate the sign-in process with Google.
        // If the user cancels, `googleUser` will be null.
        final googleUser = await GoogleSignIn().signIn();
        
        // Check if the sign-in process was canceled by the user.
        if (googleUser == null) {
          // Throw a custom exception indicating that the user canceled the sign-in process.
          throw ModuleCustomCredentialException(code: 'canceled_user');
        }

        // Retrieve the authentication tokens associated with the signed-in Google user.
        final googleAuth = await googleUser.authentication;

        // Construct and return a CustomCredential using the obtained tokens.
        return CustomCredential(
          providerId: 'google',               // Identifies the provider as Google.
          accessToken: googleAuth.accessToken, // The access token for Google APIs.
          idToken: googleAuth.idToken,         // The ID token for authentication purposes.
        );
      },
      // In case of any error during the sign-in process, this error transformer
      // converts the error into a ModuleCustomCredentialException with a standard error code
      // and additional context information.
      errorTransformer: (error, [stackTrace]) => ModuleCustomCredentialException(
        code: 'failed_credential',
        optionArgs: {'social': 'Google', 'error': error.toString()},
      ),
    );
  }
}
