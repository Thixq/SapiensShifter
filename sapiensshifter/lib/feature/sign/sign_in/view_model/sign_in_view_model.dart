import 'package:core/core.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
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

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return ErrorUtil.runWithErrorHandling(
      action: () => _authManager.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
      errorHandler: ServiceErrorHandler(),
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
