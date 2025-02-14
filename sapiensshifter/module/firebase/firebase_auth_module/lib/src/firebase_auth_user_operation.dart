// ignore_for_file: prefer_constructors_over_static_methods

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/mixin/handle_exception_error_transformer_mixin.dart';

class FirebaseAuthUserOperation extends AuthOperationInterface
    with HandleExceptionErrorTransformerMixin {
  FirebaseAuthUserOperation._() {
    _initialize();
  }

  static final FirebaseAuthUserOperation _instance =
      FirebaseAuthUserOperation._();

  static FirebaseAuthUserOperation get instance => _instance;

  late final User? _user;

  void _initialize() {
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  UserModel get user {
    return UserModel(
      id: _user?.uid,
      photoUrl: _user?.photoURL,
      displayName: _user?.displayName,
      email: _user?.email,
    );
  }

  @override
  Future<bool> displayUpdate(String newName) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_user == null) throw Exception('User not initialized');
        await _user.updateDisplayName(newName);
        await _user.reload();
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  @override
  Future<bool> passwordUpdate(String newPassword) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_user == null) throw Exception('User not initialized');
        await _user.updatePassword(newPassword);
        await _user.reload();
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  @override
  Future<bool> photographUpdate(String newPhotoUrl) async {
    return handleAsyncOperation<bool, FirebaseAuthException>(
      () async {
        if (_user == null) throw Exception('User not initialized');
        await _user.updatePhotoURL(newPhotoUrl);
        await _user.reload();
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }
}
