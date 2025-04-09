import 'package:core/core.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';

final class SignInViewModel {
  SignInViewModel({required IAuthManager authManager})
      : _authManager = authManager;
  final IAuthManager _authManager;

  Future<bool> recoveryPassword({required String email}) {
    return ErrorUtil.runWithErrorHandling(
      action: () => _authManager.recoveryPassword(email: email),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: false,
    );
  }

  ///[context] value is required to draw the line on the screen with pop-up
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    return ErrorUtil.runWithErrorHandling(
      action: () => _authManager.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
      errorHandler: UIErrorHandler(context),
      fallbackValue: false,
    );
  }

  Future<bool> signInWithCredential({
    required CustomCredential signCredential,
  }) {
    return ErrorUtil.runWithErrorHandling(
      action: () =>
          _authManager.signInWithCredential(credential: signCredential),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: false,
    );
  }
}
