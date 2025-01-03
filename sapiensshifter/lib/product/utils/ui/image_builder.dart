import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
    this.iconData = Icons.image_not_supported_rounded,
    this.errorIconSize = 48,
    this.imageCacheWidth = 480,
    super.key,
  });

  final String? imageUrl;
  final int imageCacheWidth;
  final double errorIconSize;
  final IconData iconData;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      height: 50,
      width: 50,
      imageUrl ?? '',
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: child,
        );
      },
      cacheHeight: imageCacheWidth,
      cacheWidth: imageCacheWidth,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator.adaptive());
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            iconData,
            size: errorIconSize,
          ),
        );
      },
    );
  }
}
