import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/onboard_content_viewer.dart';
import 'package:sapiensshifter/feature/onboard/view/widget/onboard_page_indicator.dart';
import 'package:sapiensshifter/feature/onboard/view_model/onboard_view_model.dart';
import 'package:sapiensshifter/feature/onboard/view_model/state/onboard_state.dart';

class OnboardSlider extends StatelessWidget {
  const OnboardSlider({
    required this.pageController,
    required this.onboardViewModel,
    required this.state,
    super.key,
  });

  final PageController pageController;
  final OnboardViewModel onboardViewModel;
  final OnboardState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OnboardContentViewer(
            pageController: pageController,
            onPageChanged: onboardViewModel.pageChanged,
            contentList: onboardViewModel.contentList,
          ),
        ),
        OnboardPageIndicator(
          onNextButton: () {
            onboardViewModel.nextPage();
            if (state.isLastPage) {
              onboardViewModel.finishOnboardWrtie();
              context.router.replaceNamed('/sign/signin');
            }
          },
          onPreviousButton: onboardViewModel.previousPage,
          pageController: pageController,
          listLenght: onboardViewModel.contentList.length,
          isLastPage: state.isLastPage,
        ),
      ],
    );
  }
}
