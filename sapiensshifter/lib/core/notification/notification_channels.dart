import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationChannels {
  static const androidChannels = [
    AndroidNotificationChannelData(
      id: 'general_channel',
      name: 'General Notifications',
      description: 'Important updates and announcements',
      importance: Importance.max,
    ),
    AndroidNotificationChannelData(
      id: 'shift_channel',
      name: 'Shift Updates',
      description: 'Shift related notifications',
      importance: Importance.high,
    ),
    AndroidNotificationChannelData(
      id: 'chat_channel',
      name: 'Chat Messages',
      description: 'New message notifications',
      importance: Importance.high,
      sound: 'message_tone',
    ),
  ];
}

class AndroidNotificationChannelData {
  const AndroidNotificationChannelData({
    required this.id,
    required this.name,
    required this.description,
    required this.importance,
    this.sound,
  });
  final String id;
  final String name;
  final String description;
  final Importance importance;
  final String? sound;
}
