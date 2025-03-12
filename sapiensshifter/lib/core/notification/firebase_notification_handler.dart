// ignore_for_file: unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/notification/notification_channels.dart';
import 'package:sapiensshifter/core/notification/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class FirebaseNotificationHandler {
  FirebaseNotificationHandler(this._notificationService);
  final NotificationService _notificationService;

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

    await _setupFCMOptions();
  }

  Future<void> _setupFCMOptions() async {
    await FirebaseMessaging.instance.requestPermission();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _notificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: message.notification?.title ?? 'New Notification',
      body: message.notification?.body ?? '',
      channelId: NotificationChannels.androidChannels.first.id,
    );
  }

  // TODO(kaan): Deep linking
  void _handleBackgroundMessage(RemoteMessage message) {
    // Handle background/opened notifications
  }
}
