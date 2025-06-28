// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDeviceModel _$NotificationDeviceModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'NotificationDeviceModel',
      json,
      ($checkedConvert) {
        final val = NotificationDeviceModel(
          id: $checkedConvert('id', (v) => v as String?),
          userId: $checkedConvert('userId', (v) => v as String?),
          fcmToken: $checkedConvert('fcmToken', (v) => v as String?),
          platform: $checkedConvert('platform', (v) => v as String?),
          createdAt: $checkedConvert(
              'createdAt',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
          updatedAt: $checkedConvert(
              'updatedAt',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
        );
        return val;
      },
    );

Map<String, dynamic> _$NotificationDeviceModelToJson(
        NotificationDeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fcmToken': instance.fcmToken,
      'platform': instance.platform,
      'createdAt':
          const TimestampNullableConverter().toJson(instance.createdAt),
      'updatedAt':
          const TimestampNullableConverter().toJson(instance.updatedAt),
    };
