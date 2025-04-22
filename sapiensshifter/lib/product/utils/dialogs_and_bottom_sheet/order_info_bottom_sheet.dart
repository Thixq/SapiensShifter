import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

class OrderInfoBottomSheet extends StatelessWidget {
  const OrderInfoBottomSheet({this.tableModel, super.key});

  final TableModel? tableModel;

  String get _nullTableName => StringConstant.nullString.tr();
  String get _nullOrderName => StringConstant.nullString.tr();
  String get _nullPrice => StringConstant.nullDouble.tr();

  static Future<void> show(BuildContext context, {TableModel? tableModel}) =>
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return OrderInfoBottomSheet(
            tableModel: tableModel,
          );
        },
      );

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

  SeparatorListWidget<Widget> _buildContent(BuildContext context) {
    return SeparatorListWidget<Widget>(
      separator: context.sized.emptySizedHeightBoxLow,
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
          child: _buildOptionButton(
            context,
            title: LocaleKeys.order_info_bottom_sheet_table_delete.tr(),
            // TODO(kaan): masa silme ve yeni ürün ekleme fonksiyonları ekle.
            onPress: () {},
            borderRadius: BorderRadius.only(
              bottomLeft: context.border.normalRadius,
              topLeft: context.border.normalRadius,
            ),
            color: context.general.colorScheme.primary,
          ),
        ),
        Expanded(
          child: _buildOptionButton(
            context,
            title: LocaleKeys.order_info_bottom_sheet_new_order.tr(),
            onPress: () {},
            borderRadius: BorderRadius.only(
              bottomRight: context.border.normalRadius,
              topRight: context.border.normalRadius,
            ),
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  FilledButton _buildOptionButton(
    BuildContext context, {
    required String title,
    required VoidCallback onPress,
    required BorderRadius borderRadius,
    required Color color,
  }) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        padding: WidgetStatePropertyAll(
          context.padding.low,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
      ),
      onPressed: onPress,
      child: Text(
        title,
      ),
    );
  }

  SizedBox _buildOrderList() {
    return SizedBox(
      height: 20.h,
      child: ListView.separated(
        itemCount: tableModel?.orderList.length ?? 0,
        itemBuilder: (context, index) => Row(
          children: [
            SizedBox(
              width: 24.sp,
              height: 24.sp,
              child: ImageBuilder(
                borderRadius: BorderRadius.circular(12.sp),
                imageUrl: tableModel?.orderList[index].imagePath,
              ),
            ),
            // SizedBox(
            //   height: 24,
            //   width: 24,
            //   child: Image.network(tableModel!.orderList[index].imagePath!),
            // ),
            context.sized.emptySizedWidthBoxLow3x,
            Text(tableModel?.orderList[index].orderName ?? _nullOrderName),
            Expanded(
              child: Text(
                (tableModel?.orderList[index].price?.sapiDoubleExt
                            .priceFraction ??
                        _nullPrice)
                    .sapiExt
                    .priceSymbol,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        separatorBuilder: (context, index) =>
            context.sized.emptySizedHeightBoxLow,
      ),
    );
  }

  Align _buildTotalPrice() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        LocaleKeys.order_info_bottom_sheet_total.tr(
          namedArgs: {
            'price': tableModel?.totalPrice?.sapiDoubleExt.priceFraction ??
                _nullPrice,
          },
        ),
      ),
    );
  }
}
