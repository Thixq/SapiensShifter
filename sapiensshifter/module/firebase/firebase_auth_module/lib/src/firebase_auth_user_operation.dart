// ignore_for_file: prefer_constructors_over_static_methods

// Importing core utilities and interfaces
import 'package:core/core.dart';
// Importing Firebase Authentication package for user-related operations
import 'package:firebase_auth/firebase_auth.dart';
// Importing the mixin that transforms Firebase authentication errors
import 'utils/mixin/handle_exception_error_transformer_mixin.dart';

/// A singleton class that manages Firebase user operations.
///
/// This class provides methods for updating the user's display name, password,
/// and profile picture. It also retrieves the current user's details.
class FirebaseAuthUserOperation extends AuthOperationInterface
    with HandleExceptionErrorTransformerMixin {
  /// Private constructor to prevent external instantiation.
  ///
  /// Calls the [_initialize] method to set up the current user.
  FirebaseAuthUserOperation._() {
    _initialize();
  }

  /// Singleton instance of [FirebaseAuthUserOperation].
  static final FirebaseAuthUserOperation _instance =
      FirebaseAuthUserOperation._();

  /// Provides the singleton instance of [FirebaseAuthUserOperation].
  static FirebaseAuthUserOperation get instance => _instance;

  /// Holds the currently authenticated user.
  late User? _user;

  /// Initializes the Firebase user instance by fetching the current authenticated user.
  void _initialize() {
    _user = FirebaseAuth.instance.currentUser;
  }

  /// Returns the currently authenticated user's details as a [UserModel].
  ///
  /// If no user is authenticated, fields will be `null`.
  @override
  UserModel get user {
    return UserModel(
      id: _user?.uid,
      photoUrl: _user?.photoURL,
      displayName: _user?.displayName,
      email: _user?.email,
    );
  }

  /// Updates the user's display name.
  ///
  /// - [newName]: The new display name for the user.
  ///
  /// Returns `true` if the update is successful, otherwise throws an exception.
  @override
  Future<bool> displayUpdate(String newName) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_user == null) throw Exception('User not initialized');

        // Update the display name in Firebase
        await _user!.updateDisplayName(newName);
        await _user!.reload();

        // Refresh the user instance
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      // Handles any FirebaseAuthException that occurs during the update.
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Updates the user's password.
  ///
  /// - [newPassword]: The new password for the user.
  ///
  /// Returns `true` if the update is successful, otherwise throws an exception.
  @override
  Future<bool> passwordUpdate(String newPassword) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_user == null) throw Exception('User not initialized');

        // Update the password in Firebase
        await _user!.updatePassword(newPassword);
        await _user!.reload();

        // Refresh the user instance
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      // Handles any FirebaseAuthException that occurs during the update.
      errorTransformer: handleFirebaseAuthException,
    );
  }

  /// Updates the user's profile picture.
  ///
  /// - [newPhotoUrl]: The new profile picture URL.
  ///
  /// Returns `true` if the update is successful, otherwise throws an exception.
  @override
  Future<bool> photographUpdate(String newPhotoUrl) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_user == null) throw Exception('User not initialized');

        // Update the profile picture URL in Firebase
        await _user!.updatePhotoURL(newPhotoUrl);
        await _user!.reload();

        // Refresh the user instance
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      // Handles any FirebaseAuthException that occurs during the update.
      errorTransformer: handleFirebaseAuthException,
    );
  }
}
