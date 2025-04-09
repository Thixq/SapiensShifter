import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';

class RegisterViewModel {
  RegisterViewModel(this._authManager);

  final IAuthManager _authManager;

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
    return ErrorUtil.runWithErrorHandling(
      action: () async {
        await _authManager.registerInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _updateDisplayName(name);

        return true;
      },
      errorHandler: UIErrorHandler(context),
      fallbackValue: false,
    );
  }

  Future<void> _updateDisplayName(String name) async {
    await _authManager.authOperation.displayNameUpdate(name);
  }
}
