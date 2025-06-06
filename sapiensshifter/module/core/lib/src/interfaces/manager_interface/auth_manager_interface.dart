import 'package:core/core.dart';

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
