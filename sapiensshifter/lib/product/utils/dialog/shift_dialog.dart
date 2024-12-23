import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

class ShiftDialog extends StatelessWidget {
  const ShiftDialog({this.day, super.key});
  final ShiftDay? day;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    day?.branch ?? 'Null',
                    style: context.general.textTheme.titleMedium,
                  ),
                  Text(
                    day?.time?.ggmm ?? '--/--',
                  ),
                ],
              ),
              Text(day?.shiftStatus?.status.statusTime ?? '00:00-00:00'),
            ],
          ),
        ),
      ),
    );
  }
}
