// firebase_auth_manager.dart
// ignore_for_file: prefer_constructors_over_static_methods

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/mixin/handle_exception_error_transformer_mixin.dart';

final class FirebaseAuthManagar extends AuthManagerInterface
    with HandleExceptionErrorTransformerMixin {
  FirebaseAuthManagar._internal() {
    _init();
  }

  late final FirebaseAuth _auth;
  late final Map<String, OAuthCredential Function(CustomCredential)>
      _credentialProviders;

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
      errorTransformer: handleFirebaseAuthException,
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
      errorTransformer: handleFirebaseAuthException,
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
      errorTransformer: handleFirebaseAuthException,
    );
  }

  @override
  Future<bool> signOut() {
    return handleAsyncOperation(
      () async {
        await _auth.signOut();
        return true;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }
}
