import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class RegisterViewModel {
  RegisterViewModel(this._authManager, this._profile);

  final IAuthManager _authManager;
  final Profile _profile;

  Future<void> signout() async {
    await _authManager.signOut();
  }

  ///[context] value is required to draw the line on the screen with pop-up
  Future<bool> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _registerWithEmailAndPassword(email, password);
        await _updateDisplayName(name);
        await _saveUserToDatabase(_authManager.authOperation.user);
        return true;
      },
      errorHandler: UIErrorHandler(context),
      fallbackValue: () => false,
    );
  }

  Future<void> _saveUserToDatabase(AuthModel? auth) async {
    await _profile.createProfile(auth);
  }

  Future<AuthModel?> _registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return _authManager.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> _updateDisplayName(String name) async {
    await _authManager.authOperation.displayNameUpdate(name);
  }
}
