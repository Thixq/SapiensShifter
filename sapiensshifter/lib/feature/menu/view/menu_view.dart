import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/menu/mixin/menu_view_mixin.dart';
import 'package:sapiensshifter/feature/menu/view_model/menu_view_model.dart';
import 'package:sapiensshifter/feature/menu/view_model/state/menu_view_state.dart';
import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/models/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part './widget/menu_app_bar.dart';
part './widget/preview_product_card_grid_list.dart';
part './widget/menu_add_table_button.dart';

@RoutePage()
class MenuView extends StatefulWidget {
  const MenuView({required this.table, super.key});

  final TableModel table;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends BaseState<MenuView> with MenuViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        floatingActionButton: const AddTableButton(),
        appBar: MenuAppBar<String>(
          title: widget.table.tableName,
          onSelected: (filter) {
            debugPrint(filter.toString());
          },
        ),
        body: _content(context),
      ),
    );
  }

  Padding _content(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sized.normalValue),
      child: PreviewProductCardGridList(
        productList: List.generate(
          20,
          (index) => const ProductModel(
            productName: 'Coffee Latte',
            category: 'Soğuk',
            description: 'blabla',
            id: 'uid1',
            imagePath: 'https://cataas.com/cat',
            price: 12.49,
          ),
        ),
        onPressed: (prdouctId) {},
      ),
    );
  }
}
