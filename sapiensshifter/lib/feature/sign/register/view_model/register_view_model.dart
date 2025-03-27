import 'package:core/core.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';

class RegisterViewModel {
  RegisterViewModel(this._authManager);

  final IAuthManager _authManager;

  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    await ErrorUtil.runWithErrorHandling(
      action: () async {
        await _authManager.registerInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _updateDisplayName(name);
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: false,
    );
  }

  Future<void> _updateDisplayName(String name) async {
    await _authManager.authOperation.displayNameUpdate(name);
  }
}
