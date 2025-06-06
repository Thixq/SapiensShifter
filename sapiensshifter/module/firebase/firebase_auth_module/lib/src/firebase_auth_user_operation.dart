import 'package:core/core.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'utils/mixin/handle_exception_error_transformer_mixin.dart';

class FirebaseAuthUserOperation extends IAuthOperation
    with HandleExceptionErrorTransformerMixin {
  FirebaseAuthUserOperation(FirebaseAuth instance) {
    _firebaseAuth = instance;
  }

  late final FirebaseAuth _firebaseAuth;

  @override
  AuthModel? get user {
    if (_firebaseAuth.currentUser == null) return null;
    return AuthModel(
      id: _firebaseAuth.currentUser!.uid,
      photoUrl: _firebaseAuth.currentUser?.photoURL,
      displayName: _firebaseAuth.currentUser?.displayName,
      email: _firebaseAuth.currentUser?.email,
    );
  }

  @override
  Future<bool> displayNameUpdate(String newName) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_firebaseAuth.currentUser == null) {
          throw Exception('User not initialized');
        }

        // Update the display name in Firebase
        await _firebaseAuth.currentUser!.updateDisplayName(newName);
        await _firebaseAuth.currentUser!.reload();

        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  @override
  Future<bool> passwordUpdate(String newPassword) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_firebaseAuth.currentUser == null) {
          throw Exception('User not initialized');
        }

        // Update the password in Firebase
        await _firebaseAuth.currentUser!.updatePassword(newPassword);
        await _firebaseAuth.currentUser!.reload();

        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  @override
  Future<bool> photographUpdate(String newPhotoUrl) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_firebaseAuth.currentUser == null) {
          throw Exception('User not initialized');
        }
        // Update the profile picture URL in Firebase
        await _firebaseAuth.currentUser!.updatePhotoURL(newPhotoUrl);
        await _firebaseAuth.currentUser!.reload();

        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }
}
