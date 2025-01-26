import 'package:sapiensshifter/feature/model/custom_credential_model.dart';

abstract class AuthManagerInterface {
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<bool> registerInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<bool> signInWithCredential({required CustomCredential credential});
  Future<bool> signOut();
}
