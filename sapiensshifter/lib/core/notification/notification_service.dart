// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sapiensshifter/core/notification/notification_channels.dart';
import 'package:sapiensshifter/core/routing/routing_manager.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';

import 'package:sapiensshifter/product/models/notification_model/notification_model.dart';

@pragma('vm:entry-point')
void _notificationTapBackground(NotificationResponse notificationResponse) {
  _handleDeeplink(notificationResponse.payload);
}

Future<void> _handleDeeplink(String? path) async {
  if (path != null) {
    if (!routing.isPathActive(path)) {
      await routing.pushAndPopUntil(
        ChatRoomRoute(id: path.split('/').last),
        predicate: (route) {
          return route.isActive;
        },
      );
    }
  }
}

class NotificationService {
  NotificationService._();

  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(sound: true);
    await _initializeLocalNotifications();
    _setupMessageHandlers();
    await _coldStart();
  }

  static Future<void> _initializeLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleDeeplink(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );

    await _createAndroidChannels();
  }

  Future<void> _coldStart() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    await _handleDeeplink(notification?.data['deepLinkRoute'] as String?);
  }

  Future<bool?> requestPermissions() async {
    bool? result = false;
    if (Platform.isIOS) {
      result = await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    } else if (Platform.isAndroid) {
      result = await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
    return result;
  }

  static Future<void> _createAndroidChannels() async {
    if (Platform.isAndroid) {
      for (final channel in NotificationChannels.androidChannels.values) {
        await _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
      }
    }
  }

  static void _setupMessageHandlers() {
    FirebaseMessaging.onMessage.listen(
      (event) {
        final chatId = event.data['deepLinkRoute'] as String?;
        if (chatId != null) {
          if (!routing.isPathActive(chatId)) {
            _showLocalNotificationFromRemoteMessage(event);
          }
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) async {
        await _handleDeeplink(event.data['deepLinkRoute'] as String?);
      },
    );
  }

  static void _showLocalNotificationFromRemoteMessage(RemoteMessage message) {
    final notificaton = NotificationModel.fromRemoteMessage(message);

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        notificaton.androidChannel?.channelId ?? 'high_importance_channel',
        notificaton.androidChannel?.channelName ?? 'high_importance_channel',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
      ),
    );

    // Yerel bildirimi göster
    _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      notificaton.title,
      notificaton.body,
      notificationDetails,
      payload: notificaton.deepLinkRoute,
    );
  }
}
