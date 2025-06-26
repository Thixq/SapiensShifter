import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sapiensshifter/core/notification/notification_channels.dart';
import 'package:sapiensshifter/core/notification/notification_detail_model.dart';

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService._showLocalNotificationFromRemoteMessage(message);
}

@pragma('vm:entry-point')
void _notificationTapBackground(NotificationResponse notificationResponse) {
  selectNotificationStream.add(notificationResponse.payload);
}

class NotificationService {
  NotificationService._();

  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _initializeLocalNotifications();
    _setupMessageHandlers();
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
        selectNotificationStream.add(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );

    await _createAndroidChannels();
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
    FirebaseMessaging.onMessage.listen(_showLocalNotificationFromRemoteMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void _showLocalNotificationFromRemoteMessage(RemoteMessage message) {
    final notificatonDetailModel =
        NotificationDetailModel.fromMap(message.data);

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        notificatonDetailModel.channelId ??
            'high_importance_channel', // Kanal ID
        '', // Kanal Adı
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    // Yerel bildirimi göster
    _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      notificatonDetailModel.title,
      notificatonDetailModel.body,
      notificationDetails,
      payload: notificatonDetailModel.route,
    );
  }
}
