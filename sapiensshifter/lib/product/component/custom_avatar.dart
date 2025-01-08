import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    this.imageUrl,
    this.fallbackIcon = Icons.person,
    this.radius = 24,
    super.key,
  });
  final String? imageUrl;
  final IconData fallbackIcon;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage:
          imageUrl.ext.isNotNullOrNoEmpty ? NetworkImage(imageUrl!) : null,
      child: const Icon(Icons.image_not_supported_rounded),
    );
  }
}
