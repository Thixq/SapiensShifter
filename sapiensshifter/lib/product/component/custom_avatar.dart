import 'package:flutter/material.dart';

import 'package:sapiensshifter/product/utils/ui/image_builder.dart';

final class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    this.imageUrl,
    this.fallbackIcon = Icons.person,
    this.radius = 48,
    super.key,
  });
  final String? imageUrl;
  final IconData fallbackIcon;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: ClipOval(
        child: ImageBuilder(
          errorIconSize: radius,
          iconData: fallbackIcon,
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
