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
          chatPreviewId: $checkedConvert('chatPreviewId', (v) => v as String?),
          chatRoomId: $checkedConvert('chatRoomId', (v) => v as String?),
          members: $checkedConvert('members',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          groupName: $checkedConvert('groupName', (v) => v as String?),
          isGroup: $checkedConvert('isGroup', (v) => v as bool? ?? false),
          groupImageUrl: $checkedConvert('groupImageUrl', (v) => v as String?),
          lastMessageText:
              $checkedConvert('lastMessageText', (v) => v as String?),
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
      'chatPreviewId': instance.chatPreviewId,
      'chatRoomId': instance.chatRoomId,
      'members': instance.members,
      'isGroup': instance.isGroup,
      'groupName': instance.groupName,
      'groupImageUrl': instance.groupImageUrl,
      'lastMessageText': instance.lastMessageText,
      'lastMessageTime':
          const TimestampNullableConverter().toJson(instance.lastMessageTime),
    };
