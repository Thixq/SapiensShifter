import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/extensions/delivery_status_extension.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_rounded_shape_border.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';

final class OrderCard extends StatelessWidget {
  const OrderCard({
    this.orderModel,
    super.key,
  });

  final OrderModel? orderModel;

  String get _nullOrderName => 'OrderNameNull';
  String get _nullExtrasText => 'ExtrasNull';
  String get _nullPrice => '0.00';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      decoration: _buildDecoration(context),
      child: _bulildContent(context),
    );
  }

  Column _bulildContent(BuildContext context) {
    return Column(
      children: [
        _buildOrderCardTitle(context),
        const SizedBox(height: 8),
        _buildOrderCardExtras(context),
      ],
    );
  }

  Row _buildOrderCardTitle(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(
          imageUrl: orderModel?.imagePath,
        ),
        const SizedBox(width: 8),
        Text(
          orderModel?.orderName ?? _nullOrderName,
          style: context.general.textTheme.titleMedium,
        ),
      ],
    );
  }

  Padding _buildOrderCardExtras(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        children: [
          _buildDelivery(),
          const SizedBox(
            width: 8,
          ),
          _buildListAndPrice(context),
        ],
      ),
    );
  }

  Widget _buildDelivery() {
    return SvgAssetBuilder(
      svgPath: orderModel?.deliveryStatus.toDeliveryPath,
      errorSvgPath: 'assets/icon/ic_no_coffee.svg',
    );
  }

  Expanded _buildListAndPrice(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildExtraList(context),
          _buildPrice(context),
        ],
      ),
    );
  }

  Expanded _buildExtraList(BuildContext context) {
    return Expanded(
      child: Text(
        // ignore: unnecessary_raw_strings
        orderModel?.extras?.join(', ') ?? _nullExtrasText,
        style: context.general.textTheme.labelSmall,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Text _buildPrice(BuildContext context) {
    return Text(
      '${orderModel?.price ?? _nullPrice}${'price_symbol'.tr()}',
      style: context.general.textTheme.labelSmall,
    );
  }

  ShapeDecoration _buildDecoration(BuildContext context) {
    return ShapeDecoration(
      shape: DashedRoundedShapeBorder(
        borderSide: BorderSide(color: context.general.appTheme.hintColor),
        cornerRadius: context.border.normalRadius.x,
      ),
    );
  }
}
