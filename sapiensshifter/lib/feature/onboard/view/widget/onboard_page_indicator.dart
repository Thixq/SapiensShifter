import 'package:flutter/cupertino.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardPageIndicator extends StatelessWidget {
  const OnboardPageIndicator({
    required this.onNextButton,
    required this.onPreviousButton,
    required this.pageController,
    required this.listLenght,
    required this.isLastPage,
    super.key,
  });
  final void Function()? onNextButton;
  final void Function()? onPreviousButton;
  final PageController pageController;
  final int listLenght;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            onPressed: onPreviousButton,
            child: Text(LocaleKeys.previous.tr()),
          ),
          SmoothPageIndicator(
            controller: pageController, // PageController
            count: listLenght,
            effect: ScrollingDotsEffect(
              dotWidth: 12,
              dotHeight: 12,
              activeDotColor: context.general.colorScheme.primary,
            ),
          ),
          CupertinoButton(
            onPressed: onNextButton,
            child:
                Text(isLastPage ? LocaleKeys.done.tr() : LocaleKeys.next.tr()),
          ),
        ],
      ),
    );
  }
}
