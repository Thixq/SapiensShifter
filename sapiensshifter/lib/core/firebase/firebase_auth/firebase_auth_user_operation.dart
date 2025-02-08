// ignore_for_file: prefer_constructors_over_static_methods

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapiensshifter/core/custom_error_and_exception_hanle/async_error_handler.dart';
import 'package:sapiensshifter/core/exceptions/firebase_exception/firebase_auth_exception/firebase_auth_exception.dart';
import 'package:sapiensshifter/core/interface/operation_interface/auth_operation_interface.dart';
import 'package:sapiensshifter/core/model/sapi_user_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

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
  SapiUserModel get user {
    return SapiUserModel(
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
    return handleAsyncOperation(
      () async {
        if (_user == null) throw Exception('User not initialized');
        await _user.updatePassword(newPassword);
        await _user.reload();
        _user = FirebaseAuth.instance.currentUser;
        return true;
      },
      errorTransformer: _handleFirebaseAuthException,
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
