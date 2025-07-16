// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'NotificationModel',
      json,
      ($checkedConvert) {
        final val = NotificationModel(
          $checkedConvert('title', (v) => v as String?),
          $checkedConvert('body', (v) => v as String?),
          $checkedConvert(
              'androidChannel',
              (v) => v == null
                  ? null
                  : AndroidChannelModel.fromJson(v as Map<String, dynamic>)),
          $checkedConvert('deepLinkRoute', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'androidChannel': instance.androidChannel?.toJson(),
      'deepLinkRoute': instance.deepLinkRoute,
    };
