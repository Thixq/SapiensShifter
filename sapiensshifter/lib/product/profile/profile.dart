// ignore_for_file: join_return_with_assignment
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/constant/storage_path_constant.dart';
import 'package:sapiensshifter/product/models/branch_model/branch_model.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/utils/enums/user_role.dart';
import 'package:uuid/v4.dart';
import 'package:uuid/v7.dart';

class Profile {
  Profile._({
    required INetworkManager networkManager,
    required IAuthManager authManager,
    required IStorageManager storageManager,
  }) {
    _networkManager = networkManager;
    _authManager = authManager;
    _storageManager = storageManager;

    _user = null;
  }

  static Future<Profile> instance({
    required INetworkManager networkManager,
    required IAuthManager authManager,
    required IStorageManager storageManager,
  }) async {
    return Profile._(
      authManager: authManager,
      networkManager: networkManager,
      storageManager: storageManager,
    );
  }

  SapiensUser? get user => _user;

  late final INetworkManager _networkManager;
  late final IAuthManager _authManager;
  late final IStorageManager _storageManager;

  SapiensUser? _user;

  Future<SapiensUser> get _getCurrentProfile async {
    final uid = _authManager.authOperation.user?.id;
    final result = await _networkManager.networkOperation.getItem(
      path: '${QueryPathConstant.usersColPath}/$uid',
      model: const SapiensUser(),
    );
    return result;
  }

  Future<void> get reload async {
    _user = await _getCurrentProfile;
  }

  Future<bool> _updateUser({required Map<String, dynamic> field}) async {
    return _networkManager.networkOperation.update(
      path: '${QueryPathConstant.usersColPath}/${_user?.id}',
      value: field,
    );
  }

  Future<bool> _updateUserPreview({required Map<String, dynamic> field}) async {
    return _networkManager.networkOperation.update(
      path: '${QueryPathConstant.usersPreviewColPath}/${_user?.userPreviewId}',
      value: field,
    );
  }

  Future<bool> createProfile(AuthModel? auth) {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final userPreviewId = const UuidV4().generate();
        final userPreviewModel = UserPreviewModel(
          id: userPreviewId,
          userId: auth?.id,
          photoUrl: auth?.photoUrl,
          name: auth?.displayName,
        );
        final sapiUser = SapiensUser(
          id: auth?.id,
          userPreviewId: userPreviewId,
          name: auth?.displayName,
          email: auth?.email,
          photoUrl: auth?.photoUrl,
          role: UserRole.user,
        );

        await _networkManager.networkOperation.addItem(
          path: '${QueryPathConstant.usersColPath}/${user?.id}',
          item: sapiUser,
        );
        await _networkManager.networkOperation.addItem(
          path: '${QueryPathConstant.usersPreviewColPath}/$userPreviewId',
          item: userPreviewModel,
        );
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => false,
    );
  }

  Future<bool> updateName({required String newName}) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _authManager.authOperation.displayNameUpdate(newName);
        await _updateUser(field: {'name': newName});
        await _updateUserPreview(field: {'name': newName});
        await reload;
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => false,
    );
  }

  Future<bool> updatePassword({required String newPassword}) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _authManager.authOperation.passwordUpdate(newPassword);
        await reload;
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => false,
    );
  }

  Future<bool> updatePhoto({
    required Uint8List photoBytes,
    String? mimeType,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final imageUrl = await _photoUploadStorage(
          photoBytes: photoBytes,
          mimeType: mimeType,
        );
        if (imageUrl == null) {
          return false;
        }
        await _photoDatebaseUpdate(imageUrl);
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => false,
    );
  }

  Future<String?> _photoUploadStorage({
    required Uint8List photoBytes,
    String? mimeType,
  }) async {
    final mimeSuffix = mimeType?.split('/').last ?? 'jpg';

    final path =
        '${StoragePathConstant.usersPhotoBasePath}/${_user?.id}/${const UuidV7().generate()}.$mimeSuffix';
    return _storageManager.storageOperation
        .upload(path: path, mimeType: mimeType, byteFile: photoBytes);
  }

  Future<void> _photoDatebaseUpdate(String imageUrl) async {
    await _authManager.authOperation.photographUpdate(imageUrl);
    await _updateUser(field: {'photoUrl': imageUrl});
    await _updateUserPreview(field: {'photoUrl': imageUrl});
    await reload;
  }

  Future<bool> signOut() async {
    return _authManager.signOut();
  }

  Future<String?> get getToDayBranch async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final branch = _user?.toDayBranch;

        final result = await _networkManager.networkOperation.getItem(
          path: '${QueryPathConstant.branchColPath}/$branch',
          model: BranchModel(),
        );
        return result.name;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => null,
    );
  }
}
