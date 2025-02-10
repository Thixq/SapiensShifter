// ignore_for_file: prefer_constructors_over_static_methods

import 'dart:math';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthUserOperation extends AuthOperationInterface {
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
    return handleAsyncOperation(
      () async {
        if (_user == null) throw Exception('User not initialized');
        await _user.updateDisplayName(newName);
        await _user.reload();
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      errorTransformer: _handleFirebaseAuthException,
    );
  }

  @override
  Future<bool> passwordUpdate(String newPassword) async {
    return handleAsyncOperation<bool>(
      () async {
        if (_user == null) throw Exception('User not initialized');
        await _user.updatePassword(newPassword);
        await _user.reload();
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      errorTransformer: (error, [stackTrace]) {},
    );
  }

  @override
  Future<bool> photographUpdate(String newPhotoUrl) async {
    return handleAsyncOperation(
      () async {
        if (_user == null) throw Exception('User not initialized');
        await _user.updatePhotoURL(newPhotoUrl);
        await _user.reload();
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      errorTransformer: _handleFirebaseAuthException,
    );
  }

  Exception _handleFirebaseAuthException(dynamic error) {
    if (error is FirebaseAuthException) {
      return FirebaseAuthCustomException.fromFirebaseAuthException(error);
    }
    return Exception(
      LocaleKeys.all_exception_default_exception
          .tr(namedArgs: {'message': error.toString()}),
    );
  }
}
