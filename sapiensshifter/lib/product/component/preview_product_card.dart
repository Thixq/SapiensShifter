import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class PreviewProductCard extends StatelessWidget {
  const PreviewProductCard({
    required this.onPressed,
    required this.imageUrl,
    required this.productName,
    required this.productId,
    required this.price,
    super.key,
  });
// TODO(kaan): Bi bak.
  final void Function(String productId) onPressed;
  final String imageUrl;
  final String productName;
  final String productId;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
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
        aspectRatio: 1.21,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          cacheWidth: 480, // Daha standart bir çözünürlük
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator.adaptive());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.image_not_supported_rounded,
                size: 48,
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
            productName.sapiExt.maxChahter(16) ?? 'productNameNull',
            style: context.general.textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '${price.toStringAsFixed(2)}₺',
          style: context.general.textTheme.labelSmall,
        ),
      ],
    );
  }
}
