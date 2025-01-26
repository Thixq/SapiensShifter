// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_week_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftWeek _$ShiftWeekFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ShiftWeek',
      json,
      ($checkedConvert) {
        final val = ShiftWeek(
          id: $checkedConvert('id', (v) => v as String?),
          weekStart: $checkedConvert(
            'weekStart',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          weekEnd: $checkedConvert(
            'weekEnd',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          week: $checkedConvert(
            'week',
            (v) => (v as List<dynamic>?)
                ?.map((e) => ShiftDay.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShiftWeekToJson(ShiftWeek instance) => <String, dynamic>{
      'id': instance.id,
      'weekStart': instance.weekStart?.toIso8601String(),
      'weekEnd': instance.weekEnd?.toIso8601String(),
      'week': instance.week,
    };
