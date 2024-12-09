// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/models/preview_table_card_model.dart';

class PreviewTableCard extends StatelessWidget {
  const PreviewTableCard({required this.dataModel, this.onPressed, super.key});
  final void Function(PreviewTableCardModel dataModel)? onPressed;
  final PreviewTableCardModel dataModel;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: _previewTableCardDecoration(context),
      child: InkWell(
        onTap: () => onPressed?.call(dataModel),
        child: container(context),
      ),
    );
  }

  Container container(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      width: 42.5.w,
      height: 42.5.w,
      child: content(context),
    );
  }

  Column content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dataModel.tableName?.maxChahter(10) ?? '--',
              style: context.general.textTheme.titleMedium,
            ),
            Text(
              dataModel.getCreateClock,
              style: context.general.textTheme.bodySmall,
            ),
          ],
        ),
        Text(
          dataModel.peopleCount.toString().padLeft(2, '0'),
          style: context.general.textTheme.displayMedium,
        ),
        // TODO(kaan): Order modeli oluşturduktan sonra fiyat kısmına bak.
        FractionallySizedBox(
          widthFactor: 1,
          child: Text(
            '--₺',
            textWidthBasis: TextWidthBasis.parent,
            textAlign: TextAlign.right,
            style: context.general.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  BoxDecoration _previewTableCardDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: context.border.normalBorderRadius,
      color: context.general.colorScheme.primary,
    );
  }
}
