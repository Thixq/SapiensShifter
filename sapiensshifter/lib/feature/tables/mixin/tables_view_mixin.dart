import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/routing/model/route_aware_action_performer.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';

import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/tables/view/tables_view.dart';
import 'package:sapiensshifter/feature/tables/view_model/state/tables_view_state.dart';
import 'package:sapiensshifter/feature/tables/view_model/tables_view_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

mixin TablesViewMixin on BaseState<TablesView>
    implements RouteAwareActionPerformer {
  late final TablesViewModel _tablesViewModel;

  TablesViewModel get viewModel => _tablesViewModel;
  late final Profile profile;

  @override
  void onRoutePoppedNext() {
    _tablesViewModel.getTableList;
  }

  void newOrder(BuildContext context, TableModel? table) {
    context.router.push<TableModel>(
      MenuRoute(
        table: table!,
      ),
    );
  }

  Future<void> initial(Profile profile) async {
    await ProductConfigureItems.shiftManager.reload();
    await profile.setBranch(
      branchId:
          ProductConfigureItems.shiftManager.toDayBranch?.branchId ?? '-1',
    );
    await _tablesViewModel.initial();
  }

  @override
  void initState() {
    profile = ProductConfigureItems.profile;
    _tablesViewModel = TablesViewModel(
      TablesViewState.initial(branchName: ''),
      networkManager: ProductConfigureItems.networkManager,
      profile: profile,
    );
    initial(profile);

    super.initState();
  }
}
