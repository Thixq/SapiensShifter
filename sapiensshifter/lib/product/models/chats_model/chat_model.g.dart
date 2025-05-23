// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatModel',
      json,
      ($checkedConvert) {
        final val = ChatModel(
          chatId: $checkedConvert('chatId', (v) => v as String?),
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

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'members': instance.members,
      'isGroup': instance.isGroup,
      'groupName': instance.groupName,
      'groupImageUrl': instance.groupImageUrl,
      'lastMessageText': instance.lastMessageText,
      'lastMessageTime':
          const TimestampNullableConverter().toJson(instance.lastMessageTime),
    };
