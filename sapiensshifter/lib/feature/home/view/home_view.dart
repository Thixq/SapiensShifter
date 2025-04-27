import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/home/mixin/home_view_mixin.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part './widget/nav_bar.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      resizeToAvoidBottomInset: false,
      routes: pages
          .map(
            (e) => e.page,
          )
          .toList(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButtonBuilder: (context, tabsRouter) {
        return NavBar(
          initalIndex: tabsRouter.activeIndex,
          onChange: (index) => tabsRouter.setActiveIndex(index),
          navBarItem: navBarItems,
        );
      },
    );
  }
}
