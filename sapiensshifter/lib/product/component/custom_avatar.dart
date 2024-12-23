import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    required this.imageUrl,
    this.fallbackIcon = Icons.person,
    this.radius = 24,
    super.key,
  });
  final String imageUrl;
  final IconData fallbackIcon;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: NetworkImage(imageUrl),
      onForegroundImageError: (_, __) {
        // TODO(kaan): Global exception ekle.
        debugPrint('Failed to load avatar image: $imageUrl');
      },
      child: Icon(fallbackIcon),
    );
  }
}
