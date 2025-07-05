part of '../profile.dart';

class ProfileSessionState {
  const ProfileSessionState({
    this.workingStatus = WorkingStatusEnum.UNASSIGNED,
    this.todayBranchId,
  });
  final WorkingStatusEnum workingStatus;
  final String? todayBranchId;

  ProfileSessionState copyWith({
    WorkingStatusEnum? workingStatus,
    String? todayBranchId,
  }) {
    return ProfileSessionState(
      workingStatus: workingStatus ?? this.workingStatus,
      todayBranchId: todayBranchId ?? this.todayBranchId,
    );
  }
}
