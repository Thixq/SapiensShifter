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
      leading: CircleAvatar(
        radius: 24,
        foregroundImage: NetworkImage(imageUrl),
        child: Icon(onErrorIcon ?? Icons.person),
      ),
      title: Text(
        title,
        style: context.general.textTheme.titleMedium,
      ),
      subtitle: Text(
        lastMessage,
        style: context.general.textTheme.bodySmall!
            .copyWith(color: const Color(0xff6a6a6a)),
      ),
      onTap: onPressed,
    );
  }
}
