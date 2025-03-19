import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_auth_user_operation.dart';
import 'utils/mixin/handle_exception_error_transformer_mixin.dart';

/// Manages user authentication using Firebase Auth.
/// Supports email/password and social logins (Google, Apple).
final class FirebaseAuthManagar extends IAuthManager
    with HandleExceptionErrorTransformerMixin {
  /// Private constructor that initializes Firebase Auth and related operations.
  FirebaseAuthManagar._internal(FirebaseAuth firebaseAuth)
      : super(FirebaseAuthUserOperation(firebaseAuth)) {
    _auth = firebaseAuth;
    _init();
  }

  /// Creates an instance using the provided FirebaseAuth.
  static FirebaseAuthManagar instanceFor(FirebaseAuth firebaseAuth) {
    return FirebaseAuthManagar._internal(firebaseAuth);
  }

  /// Returns a singleton instance of FirebaseAuthManagar.
  static FirebaseAuthManagar get instance =>
      FirebaseAuthManagar._internal(FirebaseAuth.instance);

  /// Sets up social login providers with their credential functions.
  void _init() {
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

  /// The FirebaseAuth instance for authentication operations.
  static late FirebaseAuth _auth;

  /// Maps social providers to functions that create OAuth credentials.
  late final Map<String, OAuthCredential Function(CustomCredential)>
      _credentialProviders;

  /// Registers a new user using email and password.
  ///
  /// [email]: User's email address.
  /// [password]: User's password.
  /// Returns true if registration is successful; otherwise, throws an error.
  @override
  Future<bool> registerInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return handleAsyncOperation(
      () async {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Signs in a user using social login credentials.
  ///
  /// [credential]: The credential from a social provider.
  /// Returns true if sign-in is successful; otherwise, throws an error.
  @override
  Future<bool> signInWithCredential({
    required CustomCredential credential,
  }) async {
    return handleAsyncOperation(
      () async {
        // Get the credential function for the provider.
        final providerFunction = _credentialProviders[credential.providerId];

        // If the provider is not supported, throw an error.
        if (providerFunction == null) {
          throw UnimplementedError(
            'Provider ${credential.providerId} is not supported',
          );
        }

        // Create the OAuth credential and sign in.
        final oAuthCredential = providerFunction(credential);
        await _auth.signInWithCredential(oAuthCredential);
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Signs in a user using email and password.
  ///
  /// [email]: User's email address.
  /// [password]: User's password.
  /// Returns true if sign-in is successful; otherwise, throws an error.
  @override
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return handleAsyncOperation(
      () async {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Signs out the currently logged-in user.
  ///
  /// Returns true if sign-out is successful; otherwise, throws an error.
  @override
  Future<bool> signOut() async {
    return handleAsyncOperation(
      () async {
        await _auth.signOut();
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }
}
