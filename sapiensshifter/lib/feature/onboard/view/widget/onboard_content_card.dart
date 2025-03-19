import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/model/onboard_content_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class OnboardContentCard extends StatelessWidget {
  const OnboardContentCard({required OnboardContentModel content, super.key})
      : _content = content;

  final OnboardContentModel _content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(_content.imagePath),
        Text(
          _content.title,
          style: context.general.textTheme.titleMedium,
          maxLines: 1,
        ),
        Text(
          textAlign: TextAlign.left,
          _content.desc,
          style: context.general.textTheme.bodySmall,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
