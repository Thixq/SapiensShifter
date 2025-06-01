import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/core/utils/mixin/route/route_aware_notifier_mixin.dart';
import 'package:sapiensshifter/feature/tables/mixin/tables_view_mixin.dart';
import 'package:sapiensshifter/feature/tables/view_model/state/tables_view_state.dart';
import 'package:sapiensshifter/feature/tables/view_model/tables_view_model.dart';
import 'package:sapiensshifter/product/constant/page_path_constant.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/dialogs_and_bottom_sheet.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:shimmer/shimmer.dart';

part './widget/table_grid_list.dart';
part './widget/tables_view_app_bar.dart';
part './widget/table_grid_list_shimmer.dart';

@RoutePage()
class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends BaseState<TablesView>
    with TablesViewMixin, RouteAwareNotifierStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: TablesViewAppBar(
          profile: viewModel.sapiensUser,
          onTap: () => context.router.pushPath(PagePathConstant.settings),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<TablesViewModel, TablesViewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _waitingShimmer(context);
        }
        return _content(context, state.tableList);
      },
    );
  }

  Widget _content(
    BuildContext context,
    List<TableModel> tableList,
  ) {
    return _buildPadding(
      context,
      child: TableGrid(
        tableList: tableList,
        onPress: (table) => OrderInfoBottomSheet.show(
          context,
          tableModel: table,
          onPressDelete: () async => viewModel.deleteTable(table!),
          onPressAddNewOrder: () => newOrder(context, table),
        ),
      ),
    );
  }

  Widget _waitingShimmer(BuildContext context) {
    return _buildPadding(context, child: const TableGridListShimmer());
  }

  Padding _buildPadding(BuildContext context, {required Widget child}) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.sized.normalValue,
        right: context.sized.normalValue,
        top: context.sized.normalValue,
      ),
      child: child,
    );
  }
}
