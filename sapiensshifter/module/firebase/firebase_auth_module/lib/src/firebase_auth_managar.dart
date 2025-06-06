import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_auth_user_operation.dart';
import 'utils/mixin/handle_exception_error_transformer_mixin.dart';

final class FirebaseAuthManagar extends IAuthManager
    with HandleExceptionErrorTransformerMixin {
  FirebaseAuthManagar._internal(FirebaseAuth firebaseAuth)
      : super(FirebaseAuthUserOperation(firebaseAuth)) {
    _auth = firebaseAuth;
    _init();
  }

  static FirebaseAuthManagar instanceFor(FirebaseAuth firebaseAuth) {
    return FirebaseAuthManagar._internal(firebaseAuth);
  }

  static FirebaseAuthManagar get instance =>
      FirebaseAuthManagar._internal(FirebaseAuth.instance);

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

  static late FirebaseAuth _auth;

  late final Map<String, OAuthCredential Function(CustomCredential)>
      _credentialProviders;

  @override
  Future<AuthModel?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return handleAsyncOperation(
      () async {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return authOperation.user;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

  @override
  Future<AuthModel?> signInWithCredential({
    required CustomCredential credential,
  }) async {
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
        return authOperation.user;
      },
      errorTransformer: handleFirebaseAuthException,
    );
  }

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

  @override
  Future<bool> recoveryPassword({required String email}) async {
    return handleAsyncOperation(() async {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    }, errorTransformer: handleFirebaseAuthException);
  }
}
