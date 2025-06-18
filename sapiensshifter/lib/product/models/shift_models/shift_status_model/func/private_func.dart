// ignore_for_file: library_private_types_in_public_api, camel_case_types

part of '../shift_status_model.dart';

typedef _statusData = ({Color? statusColor, IconData? statusIcon});

mixin ShiftStatusMixin on IBaseModel<ShiftStatusModel> {
  _statusData statusFill({
    ShiftStatusEnum? shiftStatus,
  }) {
    switch (shiftStatus) {
      case ShiftStatusEnum.OPENING:
        return (statusColor: ColorConstant.sunShine, statusIcon: Icons.sunny);
      case ShiftStatusEnum.OPENING_SERVICE:
        return (statusColor: ColorConstant.sunShine, statusIcon: Icons.sunny);
      case ShiftStatusEnum.CLOSING:
        return (
          statusColor: ColorConstant.nightCall,
          statusIcon: Icons.nightlight
        );
      case ShiftStatusEnum.CLOSING_SERVICE:
        return (
          statusColor: ColorConstant.nightCall,
          statusIcon: Icons.nightlight
        );
      case ShiftStatusEnum.OFF_DAY:
        return (
          statusColor: ColorConstant.talkingBird,
          statusIcon: Icons.person_off_sharp
        );
      case ShiftStatusEnum.FULL_DAY:
        return (statusColor: ColorConstant.sunShine, statusIcon: Icons.sunny);
      case ShiftStatusEnum.INTERMEDIARY:
        return (
          statusColor: ColorConstant.sunShine,
          statusIcon: Icons.wb_twilight
        );
      case null:
        return (statusColor: null, statusIcon: null);
    }
  }
}
