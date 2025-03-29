part of '../home_view.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({
    required this.pageController,
    required this.pages,
    super.key,
  });

  final PageController pageController;
  final List<PageItem> pages;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: pages.length,
      itemBuilder: (context, index) => pages[index].page,
    );
  }
}
