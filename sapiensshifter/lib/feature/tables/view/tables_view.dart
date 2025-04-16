import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/tables/mixin/tables_view_mixin.dart';
import 'package:sapiensshifter/product/models/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
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

class _TablesViewState extends BaseState<TablesView> with TablesViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TablesViewAppBar(
        profile: viewModel.profile,
        height: 1,
      ),
      body: _body(),
    );
  }

  FutureBuilder<List<TableModel>> _body() {
    return FutureBuilder<List<TableModel>>(
      future: viewModel.getTableList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _waitingShimmer(context);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return _content(context, snapshot);
        }
        return _waitingShimmer(context);
      },
    );
  }

  Widget _content(
    BuildContext context,
    AsyncSnapshot<List<TableModel>> snapshot,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.sized.normalValue,
        right: context.sized.normalValue,
        top: context.sized.normalValue,
      ),
      child: TableGrid(
        tableList: snapshot.data!,
        onPress: (table) =>
            OrderInfoBottomSheet.show(context, tableModel: table),
      ),
    );
  }

  Widget _waitingShimmer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.sized.normalValue,
        right: context.sized.normalValue,
        top: context.sized.normalValue,
      ),
      child: const TableGridListShimmer(),
    );
  }
}
