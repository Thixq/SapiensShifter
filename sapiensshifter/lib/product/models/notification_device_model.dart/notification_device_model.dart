// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'notification_device_model.g.dart';

@JsonSerializable(checked: true)
class NotificationDeviceModel extends IBaseModel<NotificationDeviceModel>
    with EquatableMixin {
  final String? userId;
  final String? fcmToken;
  final String? platform;
  @TimestampNullableConverter()
  final DateTime? createdAt;
  @TimestampNullableConverter()
  final DateTime? updatedAt;
  NotificationDeviceModel({
    super.id,
    this.userId,
    this.fcmToken,
    this.platform,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDeviceModel.create({
    required String platform,
    required String deviceId,
    required String? userId,
    required String? fcmToken,
  }) {
    final now = DateTime.now().toUtc();
    return NotificationDeviceModel(
      id: deviceId,
      createdAt: now,
      updatedAt: now,
      platform: platform,
      userId: userId,
      fcmToken: fcmToken,
    );
  }

  @override
  NotificationDeviceModel fromJson(Map<String, dynamic> json) =>
      _$NotificationDeviceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationDeviceModelToJson(this);

  NotificationDeviceModel copyWith({
    String? fcmToken,
    String? userId,
  }) {
    return NotificationDeviceModel(
      id: id,
      userId: userId ?? this.userId,
      fcmToken: fcmToken ?? this.fcmToken,
      platform: platform,
      createdAt: createdAt,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  @override
  List<Object?> get props => [id, fcmToken, userId, platform];
}
