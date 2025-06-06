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
          id: $checkedConvert('id', (v) => v as String?),
          senderId: $checkedConvert('senderId', (v) => v as String?),
          text: $checkedConvert('text', (v) => v as String?),
          timeStamp: $checkedConvert(
              'timeStamp',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
        );
        return val;
      },
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'text': instance.text,
      'timeStamp':
          const TimestampNullableConverter().toJson(instance.timeStamp),
    };
