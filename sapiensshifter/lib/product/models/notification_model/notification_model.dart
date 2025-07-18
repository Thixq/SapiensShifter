import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/core/notification/notification_channels.dart';
import 'package:sapiensshifter/product/models/notification_model/android_channel_model.dart';

part 'notification_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
class NotificationModel extends IBaseModel<NotificationModel>
    with EquatableMixin {
  NotificationModel(
    this.title,
    this.body,
    this.androidChannel,
    this.deepLinkRoute,
  );

  factory NotificationModel.fromRemoteMessage(RemoteMessage notification) {
    final notificationJson = <String, dynamic>{
      'title': notification.notification?.title,
      'body': notification.notification?.body,
      'deepLinkRoute': notification.data['deepLinkRoute'],
      'androidChannel': {
        'channelId': notification.notification?.android?.channelId,
        'channelName': NotificationChannels
            .androidChannels[notification.notification?.android?.channelId],
        'channelDescription': NotificationChannels
            .androidChannels[notification.notification?.android?.channelId],
      },
    };

    return NotificationModel.fromJson(notificationJson);
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  final String? title;
  final String? body;
  final AndroidChannelModel? androidChannel;
  final String? deepLinkRoute;

  @override
  NotificationModel fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [title, body, androidChannel, deepLinkRoute];
}
