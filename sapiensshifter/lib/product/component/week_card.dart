// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/constant/color_constant.dart';
import 'package:sapiensshifter/product/utils/dialog/shift_dialog.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

final class WeekCard extends StatelessWidget {
  WeekCard({
    this.shiftDay,
    super.key,
  });
  final double _width = 12.w; // Adjusted for responsive width
  final double _fontSize = 20.sp; // Font size proportional to screen width
  final double _iconSize = 6.w; // Icon size proportional to screen width
  final ShiftDay? shiftDay;

  BoxBorder? get isToday {
    final shiftDayGGMM = shiftDay?.time?.ggmm;
    if (shiftDayGGMM == null) return null;
    return shiftDayGGMM == DateTime.now().ggmm
        ? Border.all(width: 4, color: ColorConstant.primaryColor)
        : null;
  }

  void showShiftDay(BuildContext context) {
    context.popupManager.showLoader(
      barrierDismissible: true,
      widgetBuilder: (context) => ShiftDialog(
        day: shiftDay,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: _buildDecoration(context),
      child: InkWell(
        onTap: () => showShiftDay(context),
        borderRadius: context.border.lowBorderRadius,
        child: _buildContent(context),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: context.border.lowBorderRadius,
      color: Colors.white,
      border: isToday,
    );
  }

  Container _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1.5.h, top: .5.h),
      width: _width,
      child: Column(
        children: [
          _buildDateText(context, _fontSize, shiftDay?.time),
          SizedBox(height: .8.h),
          _buildShiftStatus(_iconSize, shiftDay?.shiftStatus, context),
        ],
      ),
    );
  }

  FractionallySizedBox _buildShiftStatus(
    double iconSize,
    ShiftStatusEnum? shiftStatus,
    BuildContext context,
  ) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: iconSize + 2, // Dynamic height for the container
        color: shiftStatus?.status.statusColor ??
            context.general.colorScheme.primary,
        child: Icon(
          shiftStatus?.status.statusIcon,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }

  Text _buildDateText(
    BuildContext context,
    double fontSize,
    DateTime? shiftTime,
  ) {
    return Text(
      shiftTime?.day.toString().padLeft(2, '0') ?? '--',
      style: context.general.textTheme.headlineSmall!.copyWith(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
