// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class PreviewTableCard extends StatelessWidget {
  const PreviewTableCard({required this.dataModel, this.onPressed, super.key});

  final void Function(TableModel dataModel)? onPressed;
  final TableModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: _buildCardDecoration(context),
      child: InkWell(
        onTap: () => onPressed?.call(dataModel),
        borderRadius: context.border.normalBorderRadius,
        child: AspectRatio(
          aspectRatio: 1,
          child: _buildContainer(context),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeaderRow(context),
        _buildPeopleCount(context),
        _buildPriceInfo(context),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dataModel.tableName.sapiExt.maxChahter(10) ?? '--',
          style: context.general.textTheme.titleMedium,
        ),
        Text(
          dataModel.timeStamp?.hhmm ?? '--:--',
          style: context.general.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildPeopleCount(BuildContext context) {
    return Text(
      dataModel.peopleCount.toString().padLeft(2, '0'),
      style: context.general.textTheme.displayMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPriceInfo(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Text(
        // TODO(kaan): Sipariş modeli hazır olduğunda güncelleyin.
        '--₺',
        textAlign: TextAlign.right,
        style: context.general.textTheme.bodyLarge,
      ),
    );
  }

  BoxDecoration _buildCardDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: context.border.normalBorderRadius,
      color: context.general.colorScheme.primary,
    );
  }
}
