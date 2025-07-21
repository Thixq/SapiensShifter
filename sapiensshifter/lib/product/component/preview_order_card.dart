import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapiensshifter/product/component/order_card.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

final class PreviewOrderCard extends StatefulWidget {
  const PreviewOrderCard({
    required this.onDissimableOrder,
    this.tableModel,
    super.key,
  });
  final TableModel? tableModel;
  final ValueChanged<OrderModel> onDissimableOrder;

  @override
  State<PreviewOrderCard> createState() => _PreviewOrderCardState();
}

class _PreviewOrderCardState extends State<PreviewOrderCard> {
  late double? _totalPrice;
  late final List<OrderModel>? orders;

  String get _nullTableName => StringConstant.nullString.tr();

  void _updateTotalPrice(double decrease) {
    setState(() {
      if (_totalPrice != null && _totalPrice! > 0) {
        _totalPrice = _totalPrice! - decrease;
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      orders?.removeAt(index);
    });
  }

  @override
  void initState() {
    orders =
        widget.tableModel?.orderList.where((e) => e.status == true).toList();
    _totalPrice = _calculateTotalPrice(orders);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
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
        SeparatorListWidget<Widget>(
          separator: context.sized.emptySizedHeightBoxLow,
          children: _orderModelToOrderCard(context) ?? [],
        ),
      ],
    );
  }

  double? _calculateTotalPrice(List<OrderModel>? value) {
    final currentTotalPrice = value
        ?.map(
          (order) => order.price,
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
          widget.tableModel?.tableName ?? _nullTableName,
          style: context.general.textTheme.titleMedium,
        ),
        Text(
          _totalPrice.sapiDoubleExt.priceFraction.sapiExt.priceSymbol,
        ),
      ],
    );
  }

  List<Widget>? _orderModelToOrderCard(BuildContext context) {
    final filteredOrders = orders!.asMap().entries.toList();

    return filteredOrders.map((entry) {
      final index = entry.key;
      final orderModel = entry.value;

      return Slidable(
        key: ValueKey(orderModel.id),
        startActionPane: _buildSlidableActionButton(index, context, orderModel),
        child: OrderCard(orderModel: orderModel),
      );
    }).toList();
  }

  ActionPane _buildSlidableActionButton(
    int index,
    BuildContext context,
    OrderModel orderModel,
  ) {
    return ActionPane(
      dismissible: DismissiblePane(
        onDismissed: () {
          widget.onDissimableOrder(orderModel);
          _updateTotalPrice(orderModel.price ?? 0);
          _deleteItem(index);
        },
      ),
      extentRatio: .3,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(context.sized.normalValue),
            right: Radius.circular(context.sized.normalValue),
          ),
          onPressed: (context) {
            widget.onDissimableOrder(orderModel);
            _updateTotalPrice(orderModel.price ?? 0);
            _deleteItem(index);
          },
          icon: Icons.currency_lira,
          label: LocaleKeys.payment.tr(),
          backgroundColor: context.general.colorScheme.primary,
          foregroundColor: context.general.colorScheme.onPrimaryContainer,
        ),
      ],
    );
  }
}
