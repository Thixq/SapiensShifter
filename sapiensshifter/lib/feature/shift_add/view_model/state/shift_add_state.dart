// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/branch_model/branch_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

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
      week: const ShiftWeek(),
      branchs: [],
      peoples: [],
      shifts: [],
    );
  }

  final Map<int, ShiftDay> shiftMap;
  final ShiftWeek week;
  final List<UserPreviewModel> peoples;
  final List<BranchModel> branchs;
  final List<ShiftStatusModel> shifts;

  ShiftAddState copyWith({
    Map<int, ShiftDay>? shiftMap,
    ShiftWeek? week,
    List<UserPreviewModel>? peoples,
    List<BranchModel>? branchs,
    List<ShiftStatusModel>? shifts,
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
