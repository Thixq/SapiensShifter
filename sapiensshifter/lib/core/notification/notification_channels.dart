import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationChannels {
  static const androidChannels = {
    'general_channel': AndroidNotificationChannel(
      'general_channel',
      'General Notifications',
      description: 'Important updates and announcements',
      importance: Importance.max,
    ),
    'shift_channel': AndroidNotificationChannel(
      'shift_channel',
      'Shift Updates',
      description: 'Shift related notifications',
      importance: Importance.high,
    ),
    'chat_channel': AndroidNotificationChannel(
      'chat_channel',
      'Chat Messages',
      description: 'New message notifications',
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('message_tone'),
    ),
  };
}
