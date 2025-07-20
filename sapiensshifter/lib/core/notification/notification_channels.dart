import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationChannels {
  static const androidChannels = {
    'shift_channel': AndroidNotificationChannel(
      'shift_channel',
      'Shift Updates',
      description: 'Shift related notifications',
      importance: Importance.high,
    ),
    'chat_channel': AndroidNotificationChannel(
      'chat_channel',
      'Chat Messages',
      description: 'Message notifications',
      importance: Importance.high,
    ),
  };
}
