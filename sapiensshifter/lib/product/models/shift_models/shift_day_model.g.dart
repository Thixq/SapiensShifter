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
              'time',
              (v) => _$JsonConverterFromJson<Timestamp, DateTime>(
                  v, const TimestampConverter().fromJson)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShiftDayToJson(ShiftDay instance) => <String, dynamic>{
      'branch': instance.branch,
      'shiftStatus': _$ShiftStatusEnumEnumMap[instance.shiftStatus],
      'time': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.time, const TimestampConverter().toJson),
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

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
