// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class PreviewTableCard extends StatelessWidget {
  const PreviewTableCard({required this.tableModel, this.onPressed, super.key});

  final void Function(TableModel? tableModel)? onPressed;
  final TableModel? tableModel;

  int get _maxCharacter => 10;
  String get _nullDash => '--';
  String get _nullTimeDash => '--:--';

  @override
  Widget build(BuildContext context) {
    return _buildContainer(context);
  }

  Widget _buildContainer(BuildContext context) {
    return Container(
      decoration: _buildCardDecoration(context),
      padding: context.padding.normal,
      child: InkWell(
        onTap: () => onPressed?.call(tableModel),
        borderRadius: context.border.normalBorderRadius,
        child: AspectRatio(
          aspectRatio: 1,
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildNameAndTime(context),
        _buildPeopleCount(context),
        _buildPriceInfo(context),
      ],
    );
  }

  Widget _buildNameAndTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tableModel?.tableName.sapiExt.maxCharacter(_maxCharacter) ??
              _nullDash,
          style: context.general.textTheme.titleMedium,
        ),
        Text(
          tableModel?.timeStamp.sapiTimeExt.hhmm ?? _nullTimeDash,
          style: context.general.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildPeopleCount(BuildContext context) {
    return Text(
      tableModel?.peopleCount.toString().padLeft(2, '0') ?? _nullDash,
      style: context.general.textTheme.displayMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPriceInfo(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Text(
        '${tableModel?.totalPrice ?? _nullDash}'.sapiExt.priceSymbol,
        textAlign: TextAlign.right,
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
