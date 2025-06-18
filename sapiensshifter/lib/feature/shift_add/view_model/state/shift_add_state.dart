// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

import 'package:uuid/v7.dart';

final class ShiftAddState {
  ShiftAddState({
    required this.branchs,
    required this.peoples,
    required this.shifts,
    required this.shiftMap,
    required this.week,
  });

  factory ShiftAddState.initial() {
    return ShiftAddState(
      shiftMap: {},
      week: ShiftWeek(id: const UuidV7().generate()),
      branchs: {},
      peoples: {},
      shifts: {},
    );
  }

  final Map<int, ShiftDay> shiftMap;
  final ShiftWeek week;
  final Map<String, String> peoples;
  final Map<String, String> branchs;
  final Map<String, String> shifts;

  ShiftAddState copyWith({
    Map<int, ShiftDay>? shiftMap,
    ShiftWeek? week,
    Map<String, String>? peoples,
    Map<String, String>? branchs,
    Map<String, String>? shifts,
  }) {
    return ShiftAddState(
      shiftMap: shiftMap ?? this.shiftMap,
      week: week ?? this.week,
      peoples: peoples ?? this.peoples,
      branchs: branchs ?? this.branchs,
      shifts: shifts ?? this.shifts,
    );
  }
}
