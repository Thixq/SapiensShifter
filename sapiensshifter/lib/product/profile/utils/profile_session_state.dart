// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../profile.dart';

final class ProfileSessionState {
  const ProfileSessionState({
    this.workingStatus = const Unassigned(),
  });
  final WorkingStatus workingStatus;

  ProfileSessionState copyWith({
    WorkingStatus? workingStatus,
  }) {
    return ProfileSessionState(
      workingStatus: workingStatus ?? this.workingStatus,
    );
  }
}
