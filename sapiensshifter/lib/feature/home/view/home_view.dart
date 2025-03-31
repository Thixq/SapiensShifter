import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/home/mixin/home_view_mixin.dart';
import 'package:sapiensshifter/feature/home/model/page_item.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

part './widget/nav_bar.dart';
part './widget/body_page.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({@PathParam('pageIndex') required this.pageIndex, super.key});

  final int pageIndex;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BodyPage(pageController: pageController, pages: pages),
          NavBar(
            initalIndex: widget.pageIndex,
            navBarItem: navBarItems,
            onChange: goPage,
          ),
        ],
      ),
    );
  }
}
