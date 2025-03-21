import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/model/onboard_content_model.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/onboard_content_card.dart';

class OnboardContentViewer extends StatelessWidget {
  const OnboardContentViewer({
    required List<OnboardContentModel> contentList,
    required PageController pageController,
    required this.onPageChanged,
    super.key,
  })  : _contentList = contentList,
        _controller = pageController;

  final List<OnboardContentModel> _contentList;
  final PageController _controller;
  final ValueChanged<int> onPageChanged;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPageChanged,
      controller: _controller,
      itemCount: _contentList.length,
      itemBuilder: (context, index) =>
          OnboardContentCard(content: _contentList[index]),
    );
  }
}
