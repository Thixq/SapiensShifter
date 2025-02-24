import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sapiensshifter/core/notification/notification_channel_config.dart';

/// Centralized manager for creating and handling notification channels.
final class NotificationChannelManager {
  // Private constructor implementing the singleton pattern.
  NotificationChannelManager._();

  static final NotificationChannelManager instance =
      NotificationChannelManager._();

  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late final List<NotificationChannelConfig> _channels;

  /// Initializes the manager with the local notifications plugin and a list of channels.
  Future<void> initialize(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, {
    required List<NotificationChannelConfig> channels,
  }) async {
    _channels = channels;
    _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
  }

  /// Returns Android notification details for the specified [channelId].
  /// If [channelId] is null or not found, the default 'general_channel' is used.
  AndroidNotificationDetails getAndroidNotificationDetails({
    required String? channelId,
  }) {
    if (channelId == null) {
      return const AndroidNotificationDetails(
        'general_channel',
        'General Notification',
        channelDescription: 'General notifications',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        channelShowBadge: false,
      );
    }

    // Search for the configuration matching the channelId.
    final channelConfig = _channels.firstWhere(
      (element) => element.id == channelId,
      orElse: () =>
          _channels.firstWhere((element) => element.id == 'general_channel'),
    );

    return AndroidNotificationDetails(
      channelConfig.id,
      channelConfig.name,
      channelDescription: channelConfig.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      channelShowBadge: false,
    );
  }

  /// Creates all defined notification channels on the Android platform.
  Future<void> createChannels() async {
    final androidPlugin =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) return;

    // Create a notification channel for each configuration.
    for (final channelConfig in _channels) {
      final channel = AndroidNotificationChannel(
        channelConfig.id,
        channelConfig.name,
        description: channelConfig.description,
        importance: channelConfig.importance,
      );
      await androidPlugin.createNotificationChannel(channel);
    }
  }
}
