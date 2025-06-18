// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/branch_model/branch_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

final class ShiftViewState {
  ShiftViewState({
    required this.branchs,
    required this.shifts,
    required this.shiftStatus,
  });

  factory ShiftViewState.initial() {
    return ShiftViewState(shifts: [], shiftStatus: {}, branchs: {});
  }

  final List<ShiftDay> shifts;
  final Map<String, ShiftStatusModel> shiftStatus;
  final Map<String, BranchModel> branchs;

  ShiftViewState copyWith({
    List<ShiftDay>? shifts,
    Map<String, ShiftStatusModel>? shiftStatus,
    Map<String, BranchModel>? branchs,
  }) {
    return ShiftViewState(
      shifts: shifts ?? this.shifts,
      shiftStatus: shiftStatus ?? this.shiftStatus,
      branchs: branchs ?? this.branchs,
    );
  }
}
