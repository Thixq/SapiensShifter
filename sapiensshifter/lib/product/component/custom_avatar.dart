import 'package:flutter/material.dart';

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

  // TODO(kaan): Placeholder url olayına bak.
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: NetworkImage(
        imageUrl ?? '',
      ),
      onForegroundImageError: (e, __) {
        // TODO(kaan): exception ekle.
        debugPrint('Failed to load avatar image: $e');
      },
      child: Icon(fallbackIcon),
    );
  }
}
