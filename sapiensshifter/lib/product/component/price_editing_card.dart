// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

final class PriceEditingCard extends StatefulWidget {
  PriceEditingCard({
    required this.productModel,
    required this.onPress,
    this.isSelected = false,
    super.key,
  });

  final ProductModel productModel;
  bool isSelected;
  final void Function(ProductModel productModel) onPress;

  @override
  State<PriceEditingCard> createState() => _PriceEditingCardState();
}

class _PriceEditingCardState extends State<PriceEditingCard> {
  bool hasPriceChanged = false;

  @override
  void initState() {
    if (widget.productModel.originalPrice != widget.productModel.price) {
      setState(() {
        hasPriceChanged = true;
      });
    } else {
      setState(() {
        hasPriceChanged = false;
      });
    }
    super.initState();
  }

  String get _nullProductName => StringConstant.nullString.tr();
  String get _nullPrice => StringConstant.nullDouble.tr();

  @override
  void didUpdateWidget(covariant PriceEditingCard oldWidget) {
    if (widget.productModel.originalPrice != widget.productModel.price) {
      setState(() {
        hasPriceChanged = true;
      });
    } else {
      setState(() {
        hasPriceChanged = false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress(widget.productModel);
      },
      borderRadius: context.border.normalBorderRadius,
      child: Container(
        padding: context.padding.normal,
        decoration: BoxDecoration(
          borderRadius: context.border.normalBorderRadius,
          border: _buildBorder(context, widget.isSelected),
        ),
        child: _buildContent(context),
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
        SizedBox(
          height: 28.sp,
          width: 28.sp,
          child: ImageBuilder(
            imageUrl: widget.productModel.imagePath,
            borderRadius: context.border.lowBorderRadius,
          ),
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
          (widget.productModel.originalPrice?.sapiDoubleExt.priceFraction ??
                  _nullPrice)
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
