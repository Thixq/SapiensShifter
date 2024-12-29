import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class MessageInfoListTile extends StatelessWidget {
  const MessageInfoListTile({
    required this.onPressed,
    this.imageUrl,
    this.title,
    this.subTitle,
    this.onErrorIcon,
    super.key,
  });

  final String? imageUrl;
  final String? title;
  final String? subTitle;
  final IconData? onErrorIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: context.border.roundedRectangleAllBorderNormal,
      leading: CustomCircleAvatar(
        imageUrl: imageUrl,
      ),
      title: _buildTitle(context),
      subtitle: _buildSubTitle(context),
      onTap: onPressed,
    );
  }

  Widget? _buildTitle(BuildContext context) {
    return title.ext.isNullOrEmpty
        ? null
        : Text(
            title!,
            style: context.general.textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          );
  }

  Widget? _buildSubTitle(BuildContext context) {
    return subTitle.ext.isNullOrEmpty
        ? null
        : Text(
            subTitle!,
            style: context.general.textTheme.bodySmall?.copyWith(
              color: context.general.appTheme.hintColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
  }
}
