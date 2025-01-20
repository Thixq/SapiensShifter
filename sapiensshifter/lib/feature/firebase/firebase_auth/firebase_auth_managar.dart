import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapiensshifter/feature/custom_error_and_exception_hanle/async_error_handler.dart';
import 'package:sapiensshifter/feature/interface/service_interface/auth_manager_interface.dart';
import 'package:sapiensshifter/feature/model/custom_credential_model.dart';

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
      'facebook': (CustomCredential credential) =>
          FacebookAuthProvider.credential(
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
            email: email, password: password);
        return true;
      },
      errorMessage: 'Failed to register user with email and password.',
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
      errorMessage: 'Failed to sign in with credential.',
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
            email: email, password: password);
        return true;
      },
      errorMessage: 'Failed to sign in with email and password.',
    );
  }

  @override
  Future<bool> signOut() {
    return handleAsyncOperation(
      () async {
        await _auth.signOut();
        return true;
      },
      errorMessage: 'Failed to sign out.',
    );
  }
}
