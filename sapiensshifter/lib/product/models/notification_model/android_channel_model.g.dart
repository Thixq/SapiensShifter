// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android_channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AndroidChannelModel _$AndroidChannelModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AndroidChannelModel',
      json,
      ($checkedConvert) {
        final val = AndroidChannelModel(
          $checkedConvert('channelId', (v) => v as String?),
          $checkedConvert('channelName', (v) => v as String?),
          $checkedConvert('channelDescription', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$AndroidChannelModelToJson(
        AndroidChannelModel instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelName': instance.channelName,
      'channelDescription': instance.channelDescription,
    };
