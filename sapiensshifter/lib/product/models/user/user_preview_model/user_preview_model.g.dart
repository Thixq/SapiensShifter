// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreviewModel _$UserPreviewModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserPreviewModel',
      json,
      ($checkedConvert) {
        final val = UserPreviewModel(
          userId: $checkedConvert('userId', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          photoUrl: $checkedConvert('photoUrl', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserPreviewModelToJson(UserPreviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
    };
