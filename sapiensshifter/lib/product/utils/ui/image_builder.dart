import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
    IconData? iconData,
    double? errorIconSize,
    int? imageCacheWidth,
    super.key,
  })  : _imageCacheWidth = imageCacheWidth ?? 480,
        _errorIconSize = errorIconSize ?? 48,
        _iconData = iconData ?? Icons.image_not_supported_rounded;

  final String? imageUrl;
  final int _imageCacheWidth;
  final double _errorIconSize;
  final IconData _iconData;
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
      cacheHeight: _imageCacheWidth,
      cacheWidth: _imageCacheWidth,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator.adaptive());
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            _iconData,
            size: _errorIconSize,
          ),
        );
      },
    );
  }
}
