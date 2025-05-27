// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sapiens_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SapiensUser _$SapiensUserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SapiensUser',
      json,
      ($checkedConvert) {
        final val = SapiensUser(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          role: $checkedConvert(
              'role', (v) => $enumDecodeNullable(_$UserRoleEnumMap, v)),
          imagePath: $checkedConvert('imagePath', (v) => v as String?),
          toDayBranch: $checkedConvert('toDayBranch', (v) => v as String?),
          userPreviewId: $checkedConvert('userPreviewId', (v) => v as String?),
          chatPreviewIdList: $checkedConvert('chatPreviewIdList',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$SapiensUserToJson(SapiensUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'imagePath': instance.imagePath,
      'toDayBranch': instance.toDayBranch,
      'userPreviewId': instance.userPreviewId,
      'chatPreviewIdList': instance.chatPreviewIdList,
      'role': _$UserRoleEnumMap[instance.role],
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.manager: 'manager',
  UserRole.user: 'user',
};
