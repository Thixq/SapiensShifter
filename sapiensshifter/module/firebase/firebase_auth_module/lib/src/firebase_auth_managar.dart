import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/mixin/handle_exception_error_transformer_mixin.dart';

/// This class provides methods for signing in, signing out, and registering users
/// using email/password or social login providers (Google, Apple).
final class FirebaseAuthManagar extends AuthManagerInterface
    with HandleExceptionErrorTransformerMixin {
  /// Private named constructor to prevent external instantiation.
  ///
  /// This constructor initializes Firebase Authentication and the supported credential providers.
  FirebaseAuthManagar._internal() {
    _init();
  }

  /// Firebase Authentication instance used to interact with authentication services.
  late final FirebaseAuth _auth;

  /// A mapping of social authentication providers to their corresponding credential functions.
  ///
  /// This allows dynamic retrieval of OAuth credentials for supported providers (Google, Apple).
  late final Map<String, OAuthCredential Function(CustomCredential)>
      _credentialProviders;

  /// Initializes Firebase Authentication and sets up credential provider mappings.
  void _init() {
    _auth = FirebaseAuth.instance;

    // Mapping authentication providers to their respective credential retrieval functions.
    _credentialProviders = {
      'google': (CustomCredential credential) => GoogleAuthProvider.credential(
            accessToken: credential.accessToken,
            idToken: credential.idToken,
          ),
      'apple': (CustomCredential credential) => AppleAuthProvider.credential(
            credential.accessToken!,
          ),
    };
  }

  /// Provides a singleton instance of [FirebaseAuthManagar].
  ///
  /// Ensures that only one instance of this class exists throughout the app.
  static FirebaseAuthManagar get instance => FirebaseAuthManagar._internal();

  /// Registers a new user using email and password.
  ///
  /// - [email]: The user's email address.
  /// - [password]: The user's password.
  ///
  /// Returns `true` if registration is successful, otherwise an exception is thrown.
  @override
  Future<bool> registerInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return handleAsyncOperation(
      () async {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return true;
      },
      // Handles any FirebaseAuthException that occurs during registration.
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Signs in a user using third-party authentication credentials (Google, Apple).
  ///
  /// - [credential]: The authentication credentials obtained from a provider.
  ///
  /// Returns `true` if sign-in is successful, otherwise an exception is thrown.
  @override
  Future<bool> signInWithCredential({
    required CustomCredential credential,
  }) {
    return handleAsyncOperation(
      () async {
        // Retrieve the corresponding authentication function for the given provider.
        final providerFunction = _credentialProviders[credential.providerId];

        // If the provider is not supported, throw an error.
        if (providerFunction == null) {
          throw UnimplementedError(
            'Provider ${credential.providerId} is not supported',
          );
        }

        // Obtain the OAuth credential from the provider function.
        final oAuthCredential = providerFunction(credential);

        // Sign in with the obtained OAuth credential.
        await _auth.signInWithCredential(oAuthCredential);
        return true;
      },
      // Handles any FirebaseAuthException that occurs during sign-in.
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Signs in an existing user using email and password.
  ///
  /// - [email]: The user's email address.
  /// - [password]: The user's password.
  ///
  /// Returns `true` if sign-in is successful, otherwise an exception is thrown.
  @override
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return handleAsyncOperation(
      () async {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return true;
      },
      // Handles any FirebaseAuthException that occurs during sign-in.
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Signs out the currently authenticated user.
  ///
  /// Returns `true` if sign-out is successful, otherwise an exception is thrown.
  @override
  Future<bool> signOut() {
    return handleAsyncOperation(
      () async {
        await _auth.signOut();
        return true;
      },
      // Handles any FirebaseAuthException that occurs during sign-out.
      errorTransformer: handleFirebaseAuthException,
    );
  }
}
