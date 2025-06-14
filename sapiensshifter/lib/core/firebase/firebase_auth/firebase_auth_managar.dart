// ignore_for_file: prefer_constructors_over_static_methods

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapiensshifter/core/custom_error_and_exception_hanle/async_error_handler.dart';
import 'package:sapiensshifter/core/exceptions/firebase_exception/firebase_auth_exception/firebase_auth_exception.dart';
import 'package:sapiensshifter/core/interface/manager_interface/auth_manager_interface.dart';
import 'package:sapiensshifter/core/model/custom_credential_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class FirebaseAuthManagar extends AuthManagerInterface {
  FirebaseAuthManagar._internal() {
    _init();
  }

  late final FirebaseAuth _auth;

  void _init() {
    _auth = FirebaseAuth.instance;
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

  late final Map<String, OAuthCredential Function(CustomCredential)>
      _credentialProviders;

  static FirebaseAuthManagar get instance => FirebaseAuthManagar._internal();

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
      errorTransformer: (error) {
        if (error is FirebaseAuthException) {
          return FirebaseAuthCustomException.fromFirebaseAuthException(error);
        }
        return Exception(
          LocaleKeys.all_exception_default_exception
              .tr(namedArgs: {'message': error.toString()}),
        );
      },
    );
  }

  @override
  Future<bool> signInWithCredential({
    required CustomCredential credential,
  }) {
    return handleAsyncOperation(
      () async {
        final providerFunction = _credentialProviders[credential.providerId];
        if (providerFunction == null) {
          throw UnimplementedError(
            'Provider ${credential.providerId} is not supported',
          );
        }
        final oAuthCredential = providerFunction(credential);
        await _auth.signInWithCredential(oAuthCredential);
        return true;
      },
      errorTransformer: (error) {
        if (error is FirebaseAuthException) {
          return FirebaseAuthCustomException.fromFirebaseAuthException(error);
        }
        return Exception(
          LocaleKeys.all_exception_default_exception
              .tr(namedArgs: {'message': error.toString()}),
        );
      },
    );
  }

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
      errorTransformer: (error) {
        if (error is FirebaseAuthException) {
          return FirebaseAuthCustomException.fromFirebaseAuthException(error);
        }
        return Exception(
          LocaleKeys.all_exception_default_exception
              .tr(namedArgs: {'message': error.toString()}),
        );
      },
    );
  }

  @override
  Future<bool> signOut() {
    return handleAsyncOperation(
      () async {
        await _auth.signOut();
        return true;
      },
      errorTransformer: (error) {
        if (error is FirebaseAuthException) {
          return FirebaseAuthCustomException.fromFirebaseAuthException(error);
        }
        return Exception(
          LocaleKeys.all_exception_default_exception
              .tr(namedArgs: {'message': error.toString()}),
        );
      },
    );
  }
}
