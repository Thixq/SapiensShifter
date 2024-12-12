import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/export_dependency_package/component_export_package.dart';

class MessageInfoListTile extends StatelessWidget {
  const MessageInfoListTile({
    required this.imageUrl,
    required this.title,
    required this.lastMessage,
    required this.onPressed,
    this.onErrorIcon,
    super.key,
  });

  final String imageUrl;
  final String title;
  final String lastMessage;
  final IconData? onErrorIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: context.border.roundedRectangleAllBorderNormal,
      leading: _buildAvatar(context),
      title: Text(
        title,
        style: context.general.textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        lastMessage,
        style: context.general.textTheme.bodySmall?.copyWith(
          color: const Color(0xff6a6a6a),
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onPressed,
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      foregroundImage: NetworkImage(imageUrl),
      onForegroundImageError: (_, __) {
        debugPrint('Failed to load avatar image: $imageUrl');
      },
      child: Icon(onErrorIcon ?? Icons.person),
    );
  }
}
