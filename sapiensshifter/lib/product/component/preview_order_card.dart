import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class PreviewOrderCard extends StatelessWidget {
  const PreviewOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.general.colorScheme.primary,
          width: 2,
        ),
        borderRadius: context.border.lowBorderRadius,
      ),
<<<<<<< Updated upstream
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Masa 12',
                style: context.general.textTheme.titleMedium,
              ),
              const Text(
                '596₺',
              ),
            ],
=======
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
          isDismissible: true,
          separator: context.sized.emptySizedHeightBoxLow,
          onListChanged: (value) {
            final currentTotalPrice = _calculateTotalPrice(value);
            _totalPrice.value = currentTotalPrice;
          },
          children: _orderModelToOrderCard(context),
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
>>>>>>> Stashed changes
          ),
          const Divider(
            color: Colors.blue,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
