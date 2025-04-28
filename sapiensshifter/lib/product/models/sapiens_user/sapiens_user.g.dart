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
          chatPreviewIdList: $checkedConvert('chatPreviewIdList',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          imagePath: $checkedConvert('imagePath', (v) => v as String?),
          toDayBranch: $checkedConvert('toDayBranch', (v) => v as String?),
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
      'chatPreviewIdList': instance.chatPreviewIdList,
    };
