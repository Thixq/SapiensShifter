import 'package:flutter/material.dart' show Icons;
import 'package:sapiensshifter/feature/constant/color_constant.dart';
import 'package:sapiensshifter/product/models/shift_models/shift_status_model.dart';
import 'package:sapiensshifter/product/utils/enums/shift_status_enum.dart';

extension ShiftStatusExtension on ShiftStatusEnum {
  ShiftStatus get status {
    switch (this) {
      case ShiftStatusEnum.OPENING:
        return ShiftStatus(
          statusColor: ColorConstant.sunShine,
          statusIcon: Icons.sunny,
          statusTime: '08:00-16:00',
        );
      case ShiftStatusEnum.OPENING_SERVICE:
        return ShiftStatus(
          statusColor: ColorConstant.sunShine,
          statusIcon: Icons.sunny,
          statusTime: '10:00-18:00',
        );
      case ShiftStatusEnum.CLOSING:
        return ShiftStatus(
          statusColor: ColorConstant.nightCall,
          statusIcon: Icons.nightlight_round,
          statusTime: '16:00-24:00',
        );
      case ShiftStatusEnum.CLOSING_SERVICE:
        return ShiftStatus(
          statusColor: ColorConstant.nightCall,
          statusIcon: Icons.nightlight_round,
          statusTime: '15:00-23:00',
        );
      case ShiftStatusEnum.OFF_DAY:
        return ShiftStatus(statusTime: 'Off Day');
      case ShiftStatusEnum.FULL_DAY:
        return ShiftStatus(
          statusColor: ColorConstant.sunShine,
          statusIcon: Icons.schedule,
          statusTime: 'Full Day',
        );
      case ShiftStatusEnum.INTERMEDIARY:
        return ShiftStatus(
          statusColor: ColorConstant.nightCall,
          statusIcon: Icons.wb_twilight,
          statusTime: '13:00-21:00',
        );
    }
  }
}
