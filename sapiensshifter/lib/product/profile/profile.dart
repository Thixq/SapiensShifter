import 'package:core/core.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/models/sapiens_user.dart';

class Profile {
  Profile._({
    required INetworkManager networkManager,
    required IAuthManager authManager,
  }) {
    _networkManager = networkManager;
    _authManager = authManager;
    _user = null;
  }

  static Future<Profile> instance({
    required INetworkManager networkManager,
    required IAuthManager authManager,
  }) async {
    final instance =
        Profile._(authManager: authManager, networkManager: networkManager);
    await instance._reload();
    return instance;
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

  Future<void> _reload() async {
    _user = await _getCurrentProfile;
  }

  Future<void> _updateProfile({required Map<String, dynamic> field}) async {
    final updateUser = _authManager.authOperation.user;
    await _networkManager.networkOperation.update(
      path: '${QueryPathConstant.usersColPath}/${updateUser?.id}',
      value: field,
    );
  }

  Future<bool> updateName({required String newName}) async {
    return ErrorUtil.runWithErrorHandling(
      action: () async {
        await _authManager.authOperation.displayNameUpdate(newName);
        await _updateProfile(field: {'name': newName});
        return true;
      },
      fallbackValue: false,
    );
  }
}
