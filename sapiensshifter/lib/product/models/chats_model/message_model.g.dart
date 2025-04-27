// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MessageModel',
      json,
      ($checkedConvert) {
        final val = MessageModel(
          $checkedConvert('senderId', (v) => v as String?),
          $checkedConvert('message', (v) => v as String?),
          $checkedConvert(
              'timeStamp',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
        );
        return val;
      },
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'message': instance.message,
      'timeStamp':
          const TimestampNullableConverter().toJson(instance.timeStamp),
    };
