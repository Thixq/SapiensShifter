// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'MemberModel',
      json,
      ($checkedConvert) {
        final val = MemberModel(
          $checkedConvert('id', (v) => v as String?),
          $checkedConvert('name', (v) => v as String?),
          $checkedConvert('imageUrl', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
