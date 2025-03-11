import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show Importance;

/// Model representing the configuration for a notification channel.
/// Each channel has an ID, name, description, and an importance level.
final class NotificationChannelConfig {
  const NotificationChannelConfig({
    required this.id,
    required this.name,
    required this.description,
    this.importance = Importance.defaultImportance,
  });

  final String id;
  final String name;
  final String description;
  final Importance importance;

  /// Default list of notification channels used in the application.
  static List<NotificationChannelConfig> get baseNotificationChannelList => [
        const NotificationChannelConfig(
          id: 'general_channel',
          name: 'General Notification',
          description: 'General notifications',
        ),
        const NotificationChannelConfig(
          id: 'shift_channel',
          name: 'Shift Notification',
          description: 'Shifts notifications',
        ),
        const NotificationChannelConfig(
          id: 'chat_channel',
          name: 'Chat Notification',
          description: 'Chat notifications',
        ),
      ];
}
