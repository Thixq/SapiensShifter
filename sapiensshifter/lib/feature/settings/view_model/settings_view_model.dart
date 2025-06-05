import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage_module/firebase_storage_module.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';
import 'package:sapiensshifter/product/constant/stoage_path_constant.dart';

import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:uuid/v7.dart';

class SettingsViewModel {
  SettingsViewModel({
    required FirebaseStorageManager storageManager,
    required Profile profile,
  })  : _profile = profile,
        _storageManager = storageManager;

  final Profile _profile;
  final FirebaseStorageManager _storageManager;

  SapiensUser? get getUser => _profile.user;

  final settingsLogger = CustomLogger('Settings ViewModel Logger ');

  Future<String?> _phototorageFirebase({
    required Uint8List photoBytes,
    String? mimeType,
  }) async {
    final mimeTypeSplit = mimeType!.split('/').last;
    final path =
        '${StoagePathConstant.usersPhotoBasePath}/${_profile.user?.id}/${const UuidV7().generate()}.$mimeTypeSplit';
    return _storageManager.storageOperation
        .upload(path: path, byteFile: photoBytes, mimeType: mimeType);
  }

  Future<bool> updatePhoto({
    required Uint8List photoBytes,
    String? mimeType,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final imageUrl = await _phototorageFirebase(
          mimeType: mimeType,
          photoBytes: photoBytes,
        );
        settingsLogger.info('photo uploaded storage');
        if (imageUrl != null && imageUrl.isNotEmpty) {
          await _profile.updatePhoto(imageUrl: imageUrl);
          settingsLogger.info('photo update');
          return true;
        }
        return false;
      },
      customLogger: settingsLogger,
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => false,
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
