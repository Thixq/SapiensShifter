import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

final class ShiftDialog extends StatelessWidget {
  const ShiftDialog({this.shiftDay, super.key});
  final ShiftDay? shiftDay;

  static Future<void> show(
    BuildContext context, {
    ShiftDay? shiftDay,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ShiftDialog(
        shiftDay: shiftDay,
      ),
    );
  }

  String get _nullBranchText => 'Null';
  String get _nullBranchDateText => '--/--';
  String get _nullShiftTimeText => '00:00-00:00';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: context.border.roundedRectangleAllBorderNormal,
      child: IntrinsicHeight(
        child: Container(
          padding: context.padding.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBranchAndDate(context),
              _buildShiftTime(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildBranchAndDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          shiftDay?.branch ?? _nullBranchText,
          style: context.general.textTheme.titleMedium,
        ),
        Text(
          shiftDay?.time?.sapiTimeExt.ggmm ?? _nullBranchDateText,
        ),
      ],
    );
  }

  Text _buildShiftTime() =>
      Text(shiftDay?.shiftStatus?.status.statusTime ?? _nullShiftTimeText);
}
