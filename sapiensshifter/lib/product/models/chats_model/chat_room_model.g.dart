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
          $checkedConvert('id', (v) => v as String?),
          $checkedConvert(
              'members',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      UserPreviewModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
          $checkedConvert('name', (v) => v as String?),
          $checkedConvert('imageUrl', (v) => v as String?),
          $checkedConvert(
              'messages',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'messages': instance.messages?.map((e) => e.toJson()).toList(),
    };
