// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftStatusModel _$ShiftStatusModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ShiftStatusModel',
      json,
      ($checkedConvert) {
        final val = ShiftStatusModel(
          id: $checkedConvert('id', (v) => v as String?),
          range: $checkedConvert('range', (v) => v as String?),
          status: $checkedConvert('status',
              (v) => $enumDecodeNullable(_$ShiftStatusEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShiftStatusModelToJson(ShiftStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'range': instance.range,
      'status': _$ShiftStatusEnumEnumMap[instance.status],
    };

const _$ShiftStatusEnumEnumMap = {
  ShiftStatusEnum.OPENING: 'opening',
  ShiftStatusEnum.OPENING_SERVICE: 'opening_service',
  ShiftStatusEnum.CLOSING: 'closing',
  ShiftStatusEnum.CLOSING_SERVICE: 'closing_service',
  ShiftStatusEnum.OFF_DAY: 'off_day',
  ShiftStatusEnum.FULL_DAY: 'full_day',
  ShiftStatusEnum.INTERMEDIARY: 'intermediary',
};
