import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/tables/mixin/tables_view_mixin.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/models/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part './widget/table_grid_list.dart';
part './widget/tables_view_app_bar.dart';

class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends BaseState<TablesView> with TablesViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TablesViewAppBar(
        height: 1,
      ),
      body: viewModel.getTableList.ext.toBuild(
        onSuccess: (data) => Padding(
          padding: EdgeInsets.all(context.sized.normalValue),
          child: TableGrid(
            tableList: data ?? [],
          ),
        ),
        loadingWidget: const CircularProgressIndicator(),
        notFoundWidget: Container(
          color: Colors.amber,
        ),
        onError: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
