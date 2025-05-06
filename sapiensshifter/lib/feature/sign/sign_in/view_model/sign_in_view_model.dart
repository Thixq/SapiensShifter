import 'package:core/core.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:uuid/v4.dart';

final class SignInViewModel {
  SignInViewModel({
    required INetworkManager networkManager,
    required IAuthManager authManager,
  })  : _authManager = authManager,
        _networkManager = networkManager;
  final IAuthManager _authManager;
  final INetworkManager _networkManager;

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

  Future<void> _saveUserToDatabase(AuthModel? user) async {
    final userPreviewId = const UuidV4().generate();
    final userPreviewModel = UserPreviewModel(
      userPreviewId: userPreviewId,
      userId: user?.id,
      imageUrl: user?.photoUrl,
      name: user?.displayName,
    );
    final sapiUser = SapiensUser(
      id: user?.id,
      name: user?.displayName,
      email: user?.email,
      imagePath: user?.photoUrl,
    );
    await _networkManager.networkOperation.addItem(
      path: '${QueryPathConstant.usersColPath}/${user?.id}',
      item: sapiUser,
    );
    await _networkManager.networkOperation.addItem(
      path: '${QueryPathConstant.usersPreviewColPath}/$userPreviewId',
      item: userPreviewModel,
    );
  }
}
