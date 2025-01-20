import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapiensshifter/feature/custom_error_and_exception_hanle/async_error_handler.dart';
import 'package:sapiensshifter/feature/interface/operation_interface/auth_operation_interface.dart';
import 'package:sapiensshifter/feature/model/sapi_user_model.dart';

class FirebaseAuthUserOperation extends AuthOperationInterface {
  FirebaseAuthUserOperation._internal() {
    _init();
  }

  Future<void> _init() async {
    _user = FirebaseAuth.instance.currentUser;
  }

  static FirebaseAuthUserOperation get instance =>
      FirebaseAuthUserOperation._internal();

  late final User? _user;

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
        await _user?.updateDisplayName(newName);
        return true;
      },
      errorMessage: 'It even occurred while the name was being updated.',
    );
  }

  @override
  Future<bool> passwordUpdate(String newPassword) async {
    return handleAsyncOperation(
      () async {
        await _user?.updatePassword(newPassword);
        return true;
      },
      errorMessage: 'It even occurred while the password was being updated.',
    );
  }

  @override
  Future<bool> photografUpdate(String newPhotoUrl) async {
    return handleAsyncOperation(
      () async {
        await _user?.updatePhotoURL(newPhotoUrl);
        return true;
      },
      errorMessage: 'It even occurred while the photo was being updated.',
    );
  }
}
