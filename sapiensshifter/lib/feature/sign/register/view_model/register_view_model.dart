import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/model/sapiens_user.dart';

class RegisterViewModel {
  RegisterViewModel(this._authManager, this._networkManager);

  final IAuthManager _authManager;
  final INetworkManager _networkManager;

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
        await _registerWithEmailAndPassword(email, password);
        await _updateDisplayName(name);
        await _saveUserToDatabase(_authManager.authOperation.user);
        return true;
      },
      errorHandler: UIErrorHandler(context),
      fallbackValue: false,
    );
  }

  Future<void> _saveUserToDatabase(UserModel? user) async {
    final sapiUser = SapiensUser(
      id: user?.id,
      name: user?.displayName,
      email: user?.email,
      imagePath: user?.photoUrl,
    );
    await _networkManager.networkOperation
        .addItem(path: '/users/${user?.id}', item: sapiUser);
  }

  Future<UserModel?> _registerWithEmailAndPassword(
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
