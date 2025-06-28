import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:kartal/kartal.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/models/notification_device_model.dart/notification_device_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:uuid/v4.dart';

class NotificationTokenManager {
  NotificationTokenManager({
    required ILocalCacheManager localCacheManager,
    required INetworkManager networkManager,
    Profile? profile,
  })  : _localCacheManager = localCacheManager,
        _networkManager = networkManager,
        _profile = profile {
    onRefreshToken();
  }

  final ILocalCacheManager _localCacheManager;
  final INetworkManager _networkManager;
  final Profile? _profile;
  final String _deviceIdKey = 'device_id';
  final String _notificationPermissionStatusKey = 'notification_permission';

  Future<void> saveDevice() async {
    final fcmToken = await getFCMToken;
    final platform = defaultTargetPlatform;
    final deviceId = await _readOrCreateDeviceUUId();
    final notificationDeviceModel = NotificationDeviceModel.create(
      userId: _profile?.user?.id,
      deviceId: deviceId,
      fcmToken: fcmToken,
      platform: platform.name,
    );

    await _networkManager.networkOperation.addItem(
      path: '${QueryPathConstant.devicesColPath}/${notificationDeviceModel.id}',
      item: notificationDeviceModel,
    );
  }

  Future<String?> get getFCMToken async =>
      FirebaseMessaging.instance.getToken();

  void onRefreshToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (event) async {
        final id = await _readOrCreateDeviceUUId();
        await ErrorUtil.runWithErrorHandlingAsync(
          action: () async {
            await _networkManager.networkOperation.update(
              path: '${QueryPathConstant.devicesColPath}/$id',
              value: {'fcmToken': event},
            );
          },
          errorHandler: ServiceErrorHandler(),
          fallbackValue: () async {},
        );
      },
    );
  }

  Future<void> deleteDevice() async {
    final id = await _readOrCreateDeviceUUId();
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _networkManager.networkOperation
            .deleteItem(path: '${QueryPathConstant.devicesColPath}/$id');
        await _localCacheManager.cacheOperation.delete(key: _deviceIdKey);
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> _notificationPermissionStatusSet({
    required bool perrmissionStatus,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _localCacheManager.cacheOperation.write(
          key: _notificationPermissionStatusKey,
          value: perrmissionStatus,
        );
      },
      fallbackValue: () async {},
    );
  }

  Future<String> _readOrCreateDeviceUUId() async {
    final generateDeviceId = const UuidV4().generate();
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _localCacheManager.cacheOperation
            .getValue<String>(key: _deviceIdKey);
        if (result.value.ext.isNotNullOrNoEmpty) {
          return result.value;
        } else {
          await _localCacheManager.cacheOperation
              .updateValue(key: _deviceIdKey, newValue: generateDeviceId);

          return generateDeviceId;
        }
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {
        await _localCacheManager.cacheOperation
            .write(key: _deviceIdKey, value: generateDeviceId);
        return generateDeviceId;
      },
    );
  }
}
