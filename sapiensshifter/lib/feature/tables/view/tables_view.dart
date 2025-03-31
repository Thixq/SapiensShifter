import 'package:flutter/material.dart';
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

class _TablesViewState extends State<TablesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TablesViewAppBar(
        height: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(context.sized.normalValue),
        child: const TableGrid(),
      ),
    );
  }
}
