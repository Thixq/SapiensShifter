import 'package:core/src/models/custom_credential_model.dart';

/// This abstract class defines the interface for an authentication manager.
/// It contains methods for handling authentication operations such as
/// signing in, registering, signing in with custom credentials, and signing out.
abstract class IAuthManager {
  /// Signs in a user using their email and password.
  ///
  /// Parameters:
  /// - [email]: The email address of the user.
  /// - [password]: The password of the user.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the sign-in was successful, otherwise `false`.
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Registers a new user using their email and password.
  ///
  /// Parameters:
  /// - [email]: The email address of the user.
  /// - [password]: The password of the user.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the registration was successful, otherwise `false`.
  Future<bool> registerInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs in a user using a custom credential.
  ///
  /// Parameters:
  /// - [credential]: A [CustomCredential] object containing the user's credentials.
  ///   This can be used for authentication with third-party providers.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the sign-in was successful, otherwise `false`.
  Future<bool> signInWithCredential({required CustomCredential credential});

  /// Signs out the currently authenticated user.
  ///
  /// Returns:
  /// - A [Future] that resolves to `true` if the sign-out was successful, otherwise `false`.
  Future<bool> signOut();
}
