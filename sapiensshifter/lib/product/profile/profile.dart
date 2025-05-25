// ignore_for_file: join_return_with_assignment

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/models/branch_model/branch_model.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:uuid/v4.dart';

class Profile {
  Profile._({
    required INetworkManager networkManager,
    required IAuthManager authManager,
  }) {
    _networkManager = networkManager;
    _authManager = authManager;
    _user = null;
  }

  static late Profile _instance;
  static Future<Profile> instance({
    required INetworkManager networkManager,
    required IAuthManager authManager,
  }) async {
    _instance =
        Profile._(authManager: authManager, networkManager: networkManager);
    return _instance;
  }

  SapiensUser? get user => _user;

  late final INetworkManager _networkManager;
  late final IAuthManager _authManager;
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
          userPreviewId: userPreviewId,
          userId: auth?.id,
          imageUrl: auth?.photoUrl,
          name: auth?.displayName,
        );
        final sapiUser = SapiensUser(
          id: auth?.id,
          userPreviewId: userPreviewId,
          name: auth?.displayName,
          email: auth?.email,
          imagePath: auth?.photoUrl,
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
      fallbackValue: () => false,
    );
  }

  Future<bool> updatePhoto({required String newPhoto}) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _authManager.authOperation.photographUpdate(newPhoto);
        await _updateUser(field: {'imagePath': newPhoto});
        await _updateUserPreview(field: {'imagePath': newPhoto});
        await reload;
        return true;
      },
      fallbackValue: () => false,
    );
  }

  Future<bool> signOut() async {
    return _authManager.signOut();
  }

  Future<String?> get getToDayBranchId async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final branch = _user?.toDayBranch;

        final query = FirebaseFirestoreCustomQuery(
          filters: [FilterCondition(field: 'name', value: branch)],
        );

        final result = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.branchColPath,
          model: BranchModel(),
          query: query,
        );
        return result.first.id;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => null,
    );
  }
}
