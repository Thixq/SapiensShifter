import 'package:core/core.dart';

/// This abstract class defines the interface for an authentication manager.
/// It contains methods for handling authentication operations such as
/// signing in, registering, signing in with custom credentials, and signing out.
abstract class IAuthManager {
  IAuthManager(this.authOperation);

  final IAuthOperation authOperation;

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthModel?> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthModel?> signInWithCredential(
      {required CustomCredential credential});

  Future<bool> recoveryPassword({required String email});

  Future<bool> signOut();
}
