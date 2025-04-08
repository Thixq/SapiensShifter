import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/ui/image_builder.dart';

final class PreviewProductCard extends StatelessWidget {
  const PreviewProductCard({
    required this.onPressed,
    this.productModel,
    super.key,
  });
  final void Function(ProductModel? productId) onPressed;
  final ProductModel? productModel;

  Color get _cardColor => Colors.white;
  double get _cardElevation => 3;
  int get _imageCacheWidth => 480;
  double get _imageAspectRatio => 1.21;
  double get _errorIconSize => 48;
  int get _productMaxCharacter => 24;

  String get _nullProductName => StringConstant.nullString.tr();
  String get _nullPrice => StringConstant.nullDouble.tr();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _cardColor,
      elevation: _cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: context.border.normalBorderRadius,
      ),
      child: InkWell(
        borderRadius: context.border.normalBorderRadius,
        onTap: () => onPressed(productModel),
        child: Padding(
          padding: context.padding.low,
          child: Column(
            children: [
              _buildImage(context),
              context.sized.emptySizedHeightBoxLow,
              _buildTextContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: context.border.normalBorderRadius,
      child: AspectRatio(
        aspectRatio: _imageAspectRatio,
        child: ImageBuilder(
          imageUrl: productModel?.imagePath,
          imageCache: _imageCacheWidth,
          errorIconSize: _errorIconSize,
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Padding(
      padding: context.padding.horizontalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              productModel?.productName.sapiExt
                      .maxCharacter(_productMaxCharacter) ??
                  _nullProductName,
              style: context.general.textTheme.titleSmall!
                  .copyWith(fontSize: 12.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            (productModel?.price?.sapiDoubleExt.priceFraction ?? _nullPrice)
                .sapiExt
                .priceSymbol,
            style: context.general.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.w200, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
