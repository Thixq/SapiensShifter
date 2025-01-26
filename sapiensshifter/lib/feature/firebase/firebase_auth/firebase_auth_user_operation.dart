import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapiensshifter/feature/custom_error_and_exception_hanle/async_error_handler.dart';
import 'package:sapiensshifter/feature/exceptions/firebase_exception/firebase_auth_exception/firebase_auth_exception.dart';
import 'package:sapiensshifter/feature/interface/operation_interface/auth_operation_interface.dart';
import 'package:sapiensshifter/feature/model/sapi_user_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

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
        await _user?.reload();
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
  Future<bool> passwordUpdate(String newPassword) async {
    return handleAsyncOperation(
      () async {
        await _user?.updatePassword(newPassword);
        await _user?.reload();
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
  Future<bool> photografUpdate(String newPhotoUrl) async {
    return handleAsyncOperation(
      () async {
        await _user?.updatePhotoURL(newPhotoUrl);
        await _user?.reload();
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
