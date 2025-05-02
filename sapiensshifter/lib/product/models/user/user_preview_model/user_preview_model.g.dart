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
          userPreviewId: $checkedConvert('userPreviewId', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserPreviewModelToJson(UserPreviewModel instance) =>
    <String, dynamic>{
      'userPreviewId': instance.userPreviewId,
      'userId': instance.userId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
