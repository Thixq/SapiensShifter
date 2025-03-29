import 'package:flutter/widgets.dart';
import 'package:sapiensshifter/product/component/custom_nav_bar/custom_nav_bar.dart';

final class PageItem {
  PageItem({required this.page, required this.navBarItem});

  final Widget page;
  final NavBarItem navBarItem;
}
