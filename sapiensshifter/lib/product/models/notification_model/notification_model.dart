import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
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
