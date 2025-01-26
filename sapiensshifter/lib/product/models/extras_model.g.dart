// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extras_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtrasModel _$ExtrasModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ExtrasModel',
      json,
      ($checkedConvert) {
        final val = ExtrasModel(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          optionsList: $checkedConvert(
            'optionsList',
            (v) => const DoubleKeyMapConverter()
                .fromJson(v as Map<String, dynamic>?),
          ),
        );
        return val;
      },
    );

Map<String, dynamic> _$ExtrasModelToJson(ExtrasModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'optionsList': const DoubleKeyMapConverter().toJson(instance.optionsList),
    };
