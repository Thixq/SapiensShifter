import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class SettingsViewModel {
  SettingsViewModel({
    required Profile profile,
  }) : _profile = profile;

  final Profile _profile;

  SapiensUser? get getUser => _profile.user;

  final settingsLogger = CustomLogger('Settings ViewModel Logger ');

  Future<bool> updatePhoto({
    required Uint8List photoBytes,
    String? mimeType,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        settingsLogger.info('photo uploaded storage');
        await _profile.updatePhoto(
          mimeType: mimeType,
          photoBytes: photoBytes,
        );
        settingsLogger.info('photo update');
        return true;
      },
      customLogger: settingsLogger,
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

  Future<void> signOut(BuildContext context) async {
    final result = await _profile.signOut();
    if (result) {
      if (context.mounted) {
        await context.router.pushAndPopUntil(
          const SignInRoute(),
          predicate: (route) => false,
        );
      }
    }
  }
}
