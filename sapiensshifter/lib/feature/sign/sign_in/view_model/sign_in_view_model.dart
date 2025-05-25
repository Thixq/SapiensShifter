import 'package:core/core.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

final class SignInViewModel {
  SignInViewModel({
    required Profile profile,
    required IAuthManager authManager,
  })  : _authManager = authManager,
        _profile = profile;
  final IAuthManager _authManager;
  final Profile _profile;

  Future<bool> recoveryPassword({required String email}) {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () => _authManager.recoveryPassword(email: email),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => false,
    );
  }

  ///[context] value is required to draw the line on the screen with pop-up
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () => _authManager.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
      errorHandler: UIErrorHandler(context),
      fallbackValue: () => false,
    );
  }

  Future<bool> signInWithCredential({
    required CustomCredential signCredential,
  }) {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final user =
            await _authManager.signInWithCredential(credential: signCredential);
        await _saveUserToDatabase(user);
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => false,
    );
  }

  Future<void> _saveUserToDatabase(AuthModel? auth) async {
    await _profile.createProfile(auth);
  }
}
