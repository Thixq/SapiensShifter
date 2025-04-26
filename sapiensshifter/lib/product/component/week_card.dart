// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/constant/color_constant.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/shift_dialog.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

final class WeekCard extends StatelessWidget {
  const WeekCard({
    this.shiftDay,
    super.key,
  });
  final ShiftDay? shiftDay;

  BoxBorder? get isToday {
    final shiftDayGGMM = shiftDay?.time.sapiTimeExt.ggmm;
    if (shiftDayGGMM == null) return null;
    return shiftDayGGMM == DateTime.now().sapiTimeExt.ggmm
        ? Border.all(
            strokeAlign: BorderSide.strokeAlignCenter,
            width: 4.spa,
            color: ColorConstant.primaryColor,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: _buildDecoration(context),
      child: InkWell(
        borderRadius: context.border.lowBorderRadius,
        onTap: () => ShiftDialog.show(context, shiftDay: shiftDay),
        child: _buildContent(context),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.spa),
      color: Colors.white,
      border: isToday,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 5, child: _buildDateText(context, shiftDay!.time)),
        Expanded(
          flex: 3,
          child: _buildShiftStatus(context, shiftDay!.shiftStatus),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget _buildShiftStatus(
    BuildContext context,
    ShiftStatusEnum? shiftStatus,
  ) {
    return ColoredBox(
      color: shiftStatus?.status.statusColor ??
          context.general.colorScheme.primary,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Icon(
          shiftStatus?.status.statusIcon,
          color: Colors.white,
          applyTextScaling: true,
        ),
      ),
    );
  }

  Widget _buildDateText(
    BuildContext context,
    DateTime? shiftTime,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FittedBox(
        child: Text(
          '${shiftTime?.day}',
          style: context.general.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
