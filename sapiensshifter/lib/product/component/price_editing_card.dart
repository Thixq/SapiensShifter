import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/ui/image_builder.dart';

final class PriceEditingCard extends StatelessWidget {
  PriceEditingCard({
    required this.productModel,
    required this.onPress,
    super.key,
  });

  final ProductModel productModel;
  final ValueNotifier<bool> isSelect = ValueNotifier<bool>(false);
  final _previousPrice = ValueNotifier<double>(0);
  final _currentPrice = ValueNotifier<double>(0);
  final void Function(ProductModel productModel, ValueNotifier<bool> isSelect)
      onPress;

  @override
  Widget build(BuildContext context) {
    _currentPrice.value = productModel.price ?? 0;

    return InkWell(
      onTap: () {
        onPress(productModel, isSelect);
      },
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
          imageUrl: productModel.imagePath,
          borderRadius: context.border.lowBorderRadius,
        ),
        context.sized.emptySizedWidthBoxLow3x,
        Text(productModel.productName ?? 'ProductNameNull'),
      ],
    );
  }

  Widget _buildPriceInfo(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _currentPrice,
      builder: (context, value, child) {
        return Row(
          children: [
            Text(
              '${_previousPrice.value.toStringAsFixed(2)}₺',
              style: context.general.textTheme.labelSmall!
                  .copyWith(decoration: TextDecoration.lineThrough),
            ).ext.toVisible(value: value != productModel.price),
            context.sized.emptySizedWidthBoxLow,
            Text(
              '${value.toStringAsFixed(2)}₺',
              style: context.general.textTheme.titleMedium,
            ),
          ],
        );
      },
    );
  }
}
