// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Message',
      json,
      ($checkedConvert) {
        final val = Message(
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

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'text': instance.text,
      'timeStamp':
          const TimestampNullableConverter().toJson(instance.timeStamp),
    };
