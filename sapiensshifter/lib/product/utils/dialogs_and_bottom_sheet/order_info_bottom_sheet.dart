import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_utils_ui.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';
import 'package:sapiensshifter/product/utils/ui/image_builder.dart';

class OrderInfoBottomSheet extends StatelessWidget {
  const OrderInfoBottomSheet({this.tableModel, super.key});

  final TableModel? tableModel;

  String get _nullTableName => 'NullTableName';
  String get _nullOrderName => 'NullOrderName';
  double get _nullPrice => 0;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: context.sized.normalValue,
            left: context.sized.normalValue,
            right: context.sized.normalValue,
          ),
          alignment: Alignment.center,
          child: _buildContent(context),
        ),
      ),
    );
  }

  SeparatorColumn<Widget> _buildContent(BuildContext context) {
    return SeparatorColumn<Widget>(
      separator: SizedBox(
        height: context.sized.lowValue,
      ),
      children: [
        _buildTitle(context),
        _buildDeleteOrNew(context),
        _buildOrderList(),
        _buildTotalPrice(),
      ],
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      tableModel?.tableName ?? _nullTableName,
      style: context.general.textTheme.titleMedium,
    );
  }

  Row _buildDeleteOrNew(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                context.padding.low,
              ),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              LocaleKeys.order_info_bottom_sheet_table_delete.tr(),
            ),
          ),
        ),
        Expanded(
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.blue),
              padding: WidgetStatePropertyAll(
                context.padding.low,
              ),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              LocaleKeys.order_info_bottom_sheet_new_order.tr(),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _buildOrderList() {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        itemCount: tableModel?.orderList?.length ?? 0,
        itemBuilder: (context, index) => Row(
          children: [
            ImageBuilder(
              borderRadius: BorderRadius.circular(12),
              imageUrl: tableModel?.orderList?[index].imagePath,
            ),
            context.sized.emptySizedWidthBoxLow3x,
            Text(tableModel?.orderList?[index].orderName ?? _nullOrderName),
          ],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }

  Align _buildTotalPrice() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        // ignore: lines_longer_than_80_chars
        '${LocaleKeys.order_info_bottom_sheet_total.tr()}${tableModel?.totalPrice?.toStringAsFixed(2) ?? _nullPrice}${LocaleKeys.price_symbol.tr()}',
      ),
    );
  }
}
