import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/home/model/page_item.dart';
import 'package:sapiensshifter/feature/home/view/home_view.dart';
import 'package:sapiensshifter/feature/tables/view/tables_view.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/dialogs_and_bottom_sheet.dart';

mixin HomeViewMixin on BaseState<HomeView> {
  final initalIndex = 1;
  late final PageController pageController;

  List<PageItem> get pages => <PageItem>[
        PageItem(
          page: const ColoredBox(color: Colors.blue),
          navBarItem: NavBarItem(icon: Icons.message),
        ),
        PageItem(
          page: const TablesView(),
          navBarItem: NavBarItem(
            icon: Icons.table_bar,
            onPress: () {
              SapiCounterDialog.show(
                context,
                titleName: 'Masa 1',
                done: (title, count) {
                  print(title);
                  print(count);
                },
              );
            },
          ),
        ),
        PageItem(
          page: const ColoredBox(color: Colors.deepPurpleAccent),
          navBarItem: NavBarItem(icon: Icons.ssid_chart),
        ),
      ];

  List<NavBarItem> get navBarItems {
    return pages
        .map(
          (e) => e.navBarItem,
        )
        .toList();
  }

  void goPage(int value) {
    pageController.animateToPage(
      value,
      duration: const Duration(microseconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    pageController = PageController(initialPage: initalIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
