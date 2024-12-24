import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/order_card.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_divider.dart';

final class PreviewOrderCard extends StatelessWidget {
  const PreviewOrderCard({required this.orderModelList, super.key});
  final List<OrderModel> orderModelList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: context.border.normalBorderRadius,
      ),
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
          ),
          DashedDivider(
            color: context.general.colorScheme.primary,
          ),
          ...orderModelList.map(
            (orderModel) => OrderCard(context: context, orderModel: orderModel),
          ),
        ],
      ),
    );
  }
}
