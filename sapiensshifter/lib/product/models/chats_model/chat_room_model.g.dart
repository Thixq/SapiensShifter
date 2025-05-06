// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChatRoomModel',
      json,
      ($checkedConvert) {
        final val = ChatRoomModel(
          $checkedConvert('chatRoomId', (v) => v as String?),
          $checkedConvert(
              'members',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      UserPreviewModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('groupName', (v) => v as String?),
          $checkedConvert('groupImageUrl', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'groupName': instance.groupName,
      'groupImageUrl': instance.groupImageUrl,
    };
