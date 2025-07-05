part of '../profile.dart';

mixin ProfileUtilsMixin {
  WorkingStatus _handleShiftStatus({ShiftDay? shiftDay}) {
    switch (shiftDay?.shiftStatus?.status) {
      case ShiftStatusEnum.OPENING:
      case ShiftStatusEnum.OPENING_SERVICE:
      case ShiftStatusEnum.CLOSING:
      case ShiftStatusEnum.CLOSING_SERVICE:
      case ShiftStatusEnum.FULL_DAY:
      case ShiftStatusEnum.INTERMEDIARY:
        return Working(
          branchId: shiftDay?.branchId,
          branchName: shiftDay?.branchName,
        );
      case ShiftStatusEnum.OFF_DAY:
        return OffDay(reason: LocaleKeys.user_working_state_off_day.tr());
      case null:
        return Unassigned(
          reason: LocaleKeys.user_working_state_empty_day.tr(),
        );
    }
  }
}
