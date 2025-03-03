import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sapiensshifter/core/notification/notification_channel_config.dart';
import 'package:sapiensshifter/core/notification/notification_channel_manager.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Arka plan çalışırken Firebase'i başlatın
  await Firebase.initializeApp();
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _channelManager = NotificationChannelManager.instance;

  /// Servisi başlatır: bildirim ayarlarını yapar, izinleri kontrol eder ve mesaj dinleyicilerini ekler.
  Future<void> initialize() async {
    // Android ve iOS için bildirim ayarları
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _channelManager.initialize(
      _localNotificationsPlugin,
      channels: NotificationChannelConfig.baseConfigList,
    );
    await _firebaseMessaging.requestPermission();

    // Bildirime tıklandığında çalışacak callback
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    // Foreground (uygulama açıkken) gelen mesajları dinle
    FirebaseMessaging.onMessage.listen(
      (event) {
        print('object');
        _showLocalNotification(event);
      },
    );

    // Kullanıcı bildirime tıkladığında (uygulama arka planda veya kapalıyken)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Bildirim açıldı: ${message.messageId}');
      // Burada ilgili ekran yönlendirmesi yapılabilir.
    });

    final fcmToken = await _firebaseMessaging.getToken();
    debugPrint('Firebase Messaging TOKEN: $fcmToken');
  }

  /// Bildirime tıklandığında çağrılan callback
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    debugPrint(
      'Bildirim seçildi, payload: ${response.payload}',
    );
    // Payload içeriğine göre yönlendirme veya işlem gerçekleştirin.
  }

  /// Firebase’den gelen RemoteMessage’i yerel bildirim olarak gösterir
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      final channelId = message.notification?.android?.channelId;
      final androidDetails = _channelManager.getAndroidNotificationDetails(
        channelId: channelId,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentBadge: true,
        ),
      );

      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
        payload: message.data.isNotEmpty ? message.data.toString() : null,
      );
    }
  }
}
