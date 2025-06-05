import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
    this.iconData = Icons.image_not_supported_rounded,
    this.errorIconSize = 48,
    this.imageCache = 480,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String? imageUrl;
  final int imageCache;
  final double errorIconSize;
  final IconData iconData;
  final BorderRadius borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      memCacheWidth: imageCache,
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      errorWidget: (context, url, error) => Center(
        child: Icon(
          iconData,
          size: errorIconSize,
        ),
      ),
    );
  }
}
