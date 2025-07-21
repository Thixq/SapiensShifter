import 'package:auto_route/auto_route.dart';
import 'package:sapiensshifter/product/component/custom_nav_bar/custom_nav_bar.dart';

final class PageItem {
  PageItem({required this.page, required this.navBarItem});

  final PageRouteInfo<Object?> page;
  final NavBarItem navBarItem;
}
