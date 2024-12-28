import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/order_card.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_divider.dart';
import 'package:sapiensshifter/product/utils/ui/separator_column.dart';

final class PreviewOrderCard extends StatelessWidget {
  PreviewOrderCard({this.tableModel, super.key})
      : orderModelList = tableModel?.orderList ?? [];
  final TableModel? tableModel;
  late final List<OrderModel>? orderModelList;

  String get _nullTableName => 'TableNameNull';
  String get _nullPrice => '0.00';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: context.border.normalBorderRadius,
      ),
      child: _buildContent(context),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNameandTotalPrice(context),
        DashedDivider(color: context.general.colorScheme.primary),
        SeparatorColumn(
          widgets: orderModelToOrderCard(context),
          separator: context.sized.emptySizedHeightBoxNormal,
        ),
      ],
    );
  }

  Row _buildNameandTotalPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tableModel?.tableName ?? _nullTableName,
          style: context.general.textTheme.titleMedium,
        ),
        Text(
          '${tableModel?.totalPrice ?? _nullPrice}${'price_symbol'.tr()}',
        ),
      ],
    );
  }

  List<Widget>? orderModelToOrderCard(BuildContext context) => orderModelList
      ?.map((orderModel) => OrderCard(orderModel: orderModel))
      .toList();
}
