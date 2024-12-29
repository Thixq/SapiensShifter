import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/order_card.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_utils_ui.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';

final class PreviewOrderCard extends StatelessWidget {
  PreviewOrderCard({this.tableModel, super.key})
      : orderModelList = tableModel?.orderList ?? [];
  final TableModel? tableModel;
  late final List<OrderModel>? orderModelList;
  late final ValueNotifier<double> _totalPrice =
      ValueNotifier<double>(tableModel?.totalPrice ?? 0);

  String get _nullTableName => 'TableNameNull';

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
        SeparatorColumn<OrderCard>(
          widgets: _orderModelToOrderCard(context),
          separator: context.sized.emptySizedHeightBoxLow,
          onListChanged: (value) {
            final currentTotalPrice = _calculateTotalPrice(value);
            _totalPrice.value = currentTotalPrice;
          },
        ),
      ],
    );
  }

  double _calculateTotalPrice(List<OrderCard> value) {
    final currentTotalPrice = value
        .map(
          (orderCard) => orderCard.orderModel?.price,
        )
        .fold<double>(
          0,
          (previousValue, element) => previousValue + (element ?? 0),
        );
    return currentTotalPrice;
  }

  Row _buildNameandTotalPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tableModel?.tableName ?? _nullTableName,
          style: context.general.textTheme.titleMedium,
        ),
        ValueListenableBuilder(
          valueListenable: _totalPrice,
          builder: (context, value, child) => Text(
            '${value.toStringAsFixed(2)}${'price_symbol'.tr()}',
          ),
        ),
      ],
    );
  }

  List<OrderCard>? _orderModelToOrderCard(BuildContext context) =>
      orderModelList
          ?.map((orderModel) => OrderCard(orderModel: orderModel))
          .toList();
}
