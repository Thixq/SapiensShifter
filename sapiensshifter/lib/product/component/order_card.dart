import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/extensions/delivery_status_extension.dart';
import 'package:sapiensshifter/product/utils/extensions/list_extension.dart';
import 'package:sapiensshifter/product/utils/ui/dashed_rounded_shape_border.dart';
import 'package:sapiensshifter/product/utils/ui/svg_asset_builder.dart';

final class OrderCard extends StatelessWidget {
  const OrderCard({
    this.orderModel,
    super.key,
  });

  final OrderModel? orderModel;

  String get _nullOrderName => StringConstant.nullString.tr();
  String get _nullExtrasText => StringConstant.nullString.tr();
  String get _nullPrice => StringConstant.nullDouble.tr();
  String get _errorAssetPath => 'assets/icon/ic_no_coffee.svg';

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
        context.sized.emptySizedHeightBoxLow,
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
        context.sized.emptySizedWidthBoxLow3x,
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
          context.sized.emptySizedWidthBoxLow3x,
          _buildListAndPrice(context),
        ],
      ),
    );
  }

  Widget _buildDelivery() {
    return SvgAssetBuilder(
      svgPath: orderModel?.deliveryStatus.toDeliveryPath,
      errorSvgPath: _errorAssetPath,
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
        orderModel?.extras?.sapListExt
                .listItemTranslate(basePath: LocalizationPathEnum.options)
                .join(', ') ??
            _nullExtrasText,
        style: context.general.textTheme.labelSmall,
      ),
    );
  }

  Text _buildPrice(BuildContext context) {
    return Text(
      (orderModel?.price?.sapiDoubleExt.priceFraction ?? _nullPrice)
          .sapiExt
          .priceSymbol,
      style: context.general.textTheme.labelSmall,
    );
  }

  ShapeDecoration _buildDecoration(BuildContext context) {
    return ShapeDecoration(
      shape: DashedRoundedShapeBorder(
        side: BorderSide(color: context.general.appTheme.hintColor),
        borderRadius: BorderRadius.circular(context.sized.normalValue),
      ),
    );
  }
}
