// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftDay _$ShiftDayFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ShiftDay',
      json,
      ($checkedConvert) {
        final val = ShiftDay(
          branch: $checkedConvert('branch', (v) => v as String?),
          shiftStatus: $checkedConvert('shiftStatus',
              (v) => $enumDecodeNullable(_$ShiftStatusEnumEnumMap, v)),
          time: $checkedConvert(
              'time', (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShiftDayToJson(ShiftDay instance) => <String, dynamic>{
      'branch': instance.branch,
      'shiftStatus': _$ShiftStatusEnumEnumMap[instance.shiftStatus],
      'time': instance.time?.toIso8601String(),
    };

const _$ShiftStatusEnumEnumMap = {
  ShiftStatusEnum.OPENING: 'opening',
  ShiftStatusEnum.OPENING_SERVICE: 'opening_service',
  ShiftStatusEnum.CLOSING: 'closing',
  ShiftStatusEnum.CLOSING_SERVICE: 'closing_service',
  ShiftStatusEnum.OFF_DAY: 'off_Day',
  ShiftStatusEnum.FULL_DAY: 'full_day',
  ShiftStatusEnum.INTERMEDIARY: 'intermediary',
};
