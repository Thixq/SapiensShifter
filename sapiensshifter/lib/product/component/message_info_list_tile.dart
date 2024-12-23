import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class MessageInfoListTile extends StatelessWidget {
  const MessageInfoListTile({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.onPressed,
    this.onErrorIcon,
    super.key,
  });

  final String imageUrl;
  final String title;
  final String subTitle;
  final IconData? onErrorIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: context.border.roundedRectangleAllBorderNormal,
      leading: CustomCircleAvatar(
        imageUrl: imageUrl,
      ),
      title: Text(
        title,
        style: context.general.textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subTitle,
        style: context.general.textTheme.bodySmall?.copyWith(
          color: context.general.appTheme.hintColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onPressed,
    );
  }
}
