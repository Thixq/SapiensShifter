import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/ui/image_builder.dart';

final class PriceEditingCard extends StatelessWidget {
  PriceEditingCard({
    required this.productModel,
    required this.increase,
    super.key,
  });
  final ProductModel productModel;
  final double increase;
  double _previousPrice = 0;
  late final _currentPrice = ValueNotifier<double>(productModel.price ?? 0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _previousPrice = _currentPrice.value;
        _currentPrice.value += 20;
      },
      child: IntrinsicHeight(
        child: Container(
          padding: context.padding.normal,
          decoration: BoxDecoration(
            borderRadius: context.border.normalBorderRadius,
            border:
                Border.all(color: context.general.appTheme.hintColor, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageBuilder(
                    imageUrl: productModel.imagePath,
                    borderRadius: context.border.lowBorderRadius,
                  ),
                  context.sized.emptySizedWidthBoxLow3x,
                  Text(productModel.productName ?? 'ProductNameNull'),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _currentPrice,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Text(
                        '${_previousPrice.toStringAsFixed(2)}₺',
                        style: context.general.textTheme.labelSmall!
                            .copyWith(decoration: TextDecoration.lineThrough),
                      ).ext.toVisible(
                            value: value != productModel.price,
                          ),
                      context.sized.emptySizedWidthBoxLow,
                      Text(
                        '${value.toStringAsFixed(2)}₺',
                        style: context.general.textTheme.titleMedium,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
