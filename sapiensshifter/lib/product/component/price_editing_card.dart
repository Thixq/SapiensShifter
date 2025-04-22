import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

final class PriceEditingCard extends StatefulWidget {
  const PriceEditingCard({
    required this.productModel,
    required this.onPress,
    super.key,
  });

  final ProductModel productModel;
  final void Function(ProductModel productModel, ValueNotifier<bool> isSelect)
      onPress;

  @override
  State<PriceEditingCard> createState() => _PriceEditingCardState();
}

class _PriceEditingCardState extends State<PriceEditingCard> {
  final ValueNotifier<bool> isSelect = ValueNotifier<bool>(false);
  bool hasPriceChanged = false;
  double? _previousPrice = 0;
  bool _isInitialPrice = true;

  String get _nullProductName => StringConstant.nullString.tr();
  String get _nullPrice => StringConstant.nullDouble.tr();

  @override
  void didUpdateWidget(covariant PriceEditingCard oldWidget) {
    if (oldWidget.productModel.price != widget.productModel.price) {
      hasPriceChanged = true;
      if (_isInitialPrice) {
        _previousPrice = oldWidget.productModel.price;
        _isInitialPrice = false;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress(widget.productModel, isSelect);
      },
      borderRadius: context.border.normalBorderRadius,
      child: ValueListenableBuilder(
        valueListenable: isSelect,
        builder: (context, value, child) => IntrinsicHeight(
          child: Container(
            padding: context.padding.normal,
            decoration: BoxDecoration(
              borderRadius: context.border.normalBorderRadius,
              border: _buildBorder(context, value),
            ),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Border _buildBorder(BuildContext context, bool isSelect) {
    return Border.all(
      color: isSelect
          ? context.general.colorScheme.primary
          : context.general.appTheme.hintColor,
      width: 2,
    );
  }

  Row _buildContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProductInfo(context),
        _buildPriceInfo(context),
      ],
    );
  }

  Row _buildProductInfo(BuildContext context) {
    return Row(
      children: [
        ImageBuilder(
          imageUrl: widget.productModel.imagePath,
          borderRadius: context.border.lowBorderRadius,
        ),
        context.sized.emptySizedWidthBoxLow3x,
        Text(widget.productModel.productName ?? _nullProductName),
      ],
    );
  }

  Widget _buildPriceInfo(BuildContext context) {
    return Row(
      children: [
        Text(
          (_previousPrice?.sapiDoubleExt.priceFraction ?? _nullPrice)
              .sapiExt
              .priceSymbol,
          style: context.general.textTheme.labelSmall!
              .copyWith(decoration: TextDecoration.lineThrough),
        ).ext.toVisible(value: hasPriceChanged),
        context.sized.emptySizedWidthBoxLow,
        Text(
          (widget.productModel.price?.sapiDoubleExt.priceFraction ?? _nullPrice)
              .sapiExt
              .priceSymbol,
          style: context.general.textTheme.titleMedium,
        ),
      ],
    );
  }
}
