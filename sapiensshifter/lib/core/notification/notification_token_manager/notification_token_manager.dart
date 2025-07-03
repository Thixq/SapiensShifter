// ignore_for_file: prefer_constructors_over_static_methods

import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/product/models/notification_device_model.dart/notification_device_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/static_func/generate_uuid_device_id.dart';

class NotificationTokenManager {
  NotificationTokenManager._({
    required INetworkManager networkManager,
    required Profile? profile,
  })  : _networkManager = networkManager,
        _profile = profile;

  static NotificationTokenManager? _instance;

  static NotificationTokenManager get instance => instanceFor(
        networkManager: ProductConfigureItems.networkManager,
        profile: ProductConfigureItems.profile,
      );

  static NotificationTokenManager instanceFor({
    required INetworkManager networkManager,
    required Profile? profile,
  }) =>
      _instance ??= NotificationTokenManager._(
        networkManager: networkManager,
        profile: profile,
      );

  final INetworkManager _networkManager;
  final Profile? _profile;
  NotificationDeviceModel? _notificationDeviceModel;

  Future<String?> get getFCMToken async =>
      FirebaseMessaging.instance.getToken();

  Future<void> deviceSync() async {
    if (!await deviceCheck()) {
      return;
    }

    final userIdOther = _checkUserId(other: _notificationDeviceModel);
    final tokenOther = await _checkToken(other: userIdOther);
    if (tokenOther != _notificationDeviceModel) {
      await _updateDevice(other: tokenOther);
    }
    _onRefreshToken();
  }

  @visibleForTesting
  Future<bool> deviceCheck() async {
    final isDeviceExist = await _getNotificationDevice();
    if (isDeviceExist) {
      return isDeviceExist;
    }
    return _createNotificationDevice();
  }

  Future<bool> _createNotificationDevice() async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final fcmToken = await getFCMToken;
        final platform = defaultTargetPlatform;
        final deviceId = await GenerateUuidDeviceId.generateDeviceId();
        final notificationDeviceModel = NotificationDeviceModel.create(
          userId: _profile?.user?.id,
          deviceId: deviceId,
          fcmToken: fcmToken,
          platform: platform.name,
        );
        _notificationDeviceModel = notificationDeviceModel;
        await _networkManager.networkOperation.addItem(
          path: '${QueryPathConstant.devicesColPath}/$deviceId',
          item: notificationDeviceModel,
        );
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

  Future<bool> _getNotificationDevice() async {
    final deviceId = await GenerateUuidDeviceId.generateDeviceId();
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        _notificationDeviceModel =
            await _networkManager.networkOperation.getItem(
          path: '${QueryPathConstant.devicesColPath}/$deviceId',
          model: NotificationDeviceModel(),
        );
        return true;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

  NotificationDeviceModel? _checkUserId({
    NotificationDeviceModel? other,
  }) {
    if (other?.userId != _profile?.user?.id) {
      return other?.copyWith(
        userId: _profile?.user?.id,
      );
    }
    return other;
  }

  Future<NotificationDeviceModel?> _checkToken({
    NotificationDeviceModel? other,
  }) async {
    final currentToken = await getFCMToken;
    if (other?.fcmToken != currentToken) {
      return other?.copyWith(fcmToken: await getFCMToken);
    }
    return other;
  }

  Future<void> _updateDevice({NotificationDeviceModel? other}) async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _networkManager.networkOperation.update(
          path: '${QueryPathConstant.devicesColPath}/${other?.id}',
          value: other?.toJson() ?? {},
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  void _onRefreshToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (event) async {
        await _networkManager.networkOperation.update(
          path:
              '${QueryPathConstant.devicesColPath}/${_notificationDeviceModel?.id}',
          value: {'fcmToken': event},
        );
      },
    );
  }

  Future<void> deleteDevice() async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _networkManager.networkOperation.deleteItem(
          path:
              '${QueryPathConstant.devicesColPath}/${_notificationDeviceModel?.id}',
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }
}
