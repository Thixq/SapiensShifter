// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPreviewModel _$ChatPreviewModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChatPreviewModel',
      json,
      ($checkedConvert) {
        final val = ChatPreviewModel(
          id: $checkedConvert('id', (v) => v as String?),
          chatRoomId: $checkedConvert('chatRoomId', (v) => v as String?),
          chatName: $checkedConvert('chatName', (v) => v as String?),
          isGroup: $checkedConvert('isGroup', (v) => v as bool?),
          imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
          lastMessage: $checkedConvert('lastMessage', (v) => v as String?),
          lastMessageTime: $checkedConvert(
              'lastMessageTime',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ChatPreviewModelToJson(ChatPreviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'chatName': instance.chatName,
      'isGroup': instance.isGroup,
      'imageUrl': instance.imageUrl,
      'lastMessage': instance.lastMessage,
      'lastMessageTime':
          const TimestampNullableConverter().toJson(instance.lastMessageTime),
    };
