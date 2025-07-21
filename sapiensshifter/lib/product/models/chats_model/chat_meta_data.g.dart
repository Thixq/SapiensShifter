// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMetadata _$ChatMetadataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChatMetadata',
      json,
      ($checkedConvert) {
        final val = ChatMetadata(
          id: $checkedConvert('id', (v) => v as String?),
          groupName: $checkedConvert('groupName', (v) => v as String?),
          isGroup: $checkedConvert('isGroup', (v) => v as bool? ?? false),
          groupImageUrl: $checkedConvert('groupImageUrl', (v) => v as String?),
          lastMessage: $checkedConvert(
              'lastMessage',
              (v) => v == null
                  ? null
                  : Message.fromJson(v as Map<String, dynamic>)),
          members: $checkedConvert('members',
              (v) => (v as List<dynamic>?)?.map((e) => e as String?).toSet()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ChatMetadataToJson(ChatMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isGroup': instance.isGroup,
      'groupName': instance.groupName,
      'groupImageUrl': instance.groupImageUrl,
      'members': instance.members?.toList(),
      'lastMessage': instance.lastMessage?.toJson(),
    };
