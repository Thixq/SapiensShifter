import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class PreviewProductCard extends StatelessWidget {
  const PreviewProductCard({
    required this.onPressed,
    required this.imageUrl,
    required this.productName,
    required this.productId,
    required this.price,
    super.key,
  });
// TODO(kaan): Product model ekle.
  final void Function(String productId) onPressed;
  final String imageUrl;
  final String productName;
  final String productId;
  final double price;

  Color get _cardColor => Colors.white;
  double get _cardElevation => 3;
  int get _imageCacheWidth => 480;
  double get _imageAspectRatio => 1.21;
  double get _errorIconSize => 48;
  int get _productMaxCharacter => 16;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: _cardColor,
      elevation: _cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: context.border.lowBorderRadius,
      ),
      child: InkWell(
        borderRadius: context.border.lowBorderRadius,
        onTap: () => onPressed(productId),
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
      borderRadius: context.border.lowBorderRadius,
      child: AspectRatio(
        aspectRatio: _imageAspectRatio,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          cacheWidth: _imageCacheWidth, // Daha standart bir çözünürlük
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator.adaptive());
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.image_not_supported_rounded,
                size: _errorIconSize,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            productName.sapiExt.maxCharacter(_productMaxCharacter) ??
                'productNameNull',
            style: context.general.textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          // TODO(kaan): Yerelleştirme.
          '${price.toStringAsFixed(2)}₺',
          style: context.general.textTheme.labelSmall,
        ),
      ],
    );
  }
}
