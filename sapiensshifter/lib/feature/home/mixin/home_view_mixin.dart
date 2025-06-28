import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/notification/notification_service.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/home/model/page_item.dart';
import 'package:sapiensshifter/feature/home/view/home_view.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/dialogs_and_bottom_sheet.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

import 'package:uuid/v7.dart';

mixin HomeViewMixin on BaseState<HomeView> {
  final userInfo = ProductConfigureItems.profile;

  List<PageItem> get pages => <PageItem>[
        PageItem(
          page: const ChatPreviewRoute(),
          navBarItem: NavBarItem(
            icon: Icons.message,
          ),
        ),
        PageItem(
          page: const TablesRoute(),
          navBarItem: NavBarItem(
            icon: Icons.table_bar,
            onPress: () {
              SapiCounterDialog.show(
                context,
                titleName: LocaleKeys.page_home_new_table.tr(),
                done: _newTable,
              );
            },
          ),
        ),
        PageItem(
          page: const ShiftRoute(),
          navBarItem: NavBarItem(icon: Icons.ssid_chart),
        ),
      ];

  void _newTable(String tableName, int peopleCount) {
    final newTableModel = TableModel(
      peopleCount: peopleCount,
      tableName: tableName,
      branchName: userInfo.user?.toDayBranch,
      creatorId: userInfo.user?.id,
      timeStamp: DateTime.now().toLocal(),
      status: true,
      id: const UuidV7().generate(),
    );
    context.router.push<TableModel>(
      MenuRoute(
        table: newTableModel,
      ),
    );
  }

  List<NavBarItem> get navBarItems {
    return pages
        .map(
          (e) => e.navBarItem,
        )
        .toList();
  }

  @override
  void initState() {
    requestNotification();
    super.initState();
  }

  Future<void> requestNotification() async {
    final result = await NotificationService.instance.requestPermissions();
    print('Notification Status: $result');
    print(
      'Notification Token ${await ProductConfigureItems.notificationTokenManager.getFCMToken}',
    );
  }
}
