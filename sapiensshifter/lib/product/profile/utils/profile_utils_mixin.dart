part of '../profile.dart';

mixin ProfileUtilsMixin {
  WorkingStatusEnum _handleShiftStatus({ShiftStatusEnum? shiftStatus}) {
    switch (shiftStatus) {
      case ShiftStatusEnum.OPENING:
      case ShiftStatusEnum.OPENING_SERVICE:
      case ShiftStatusEnum.CLOSING:
      case ShiftStatusEnum.CLOSING_SERVICE:
      case ShiftStatusEnum.FULL_DAY:
      case ShiftStatusEnum.INTERMEDIARY:
        return WorkingStatusEnum.WORKING;
      case ShiftStatusEnum.OFF_DAY:
        return WorkingStatusEnum.OFF_DAY;
      case null:
        return WorkingStatusEnum.UNASSIGNED;
    }
  }
}
