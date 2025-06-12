import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/routing/routing_manager.gr.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/menu/mixin/menu_view_mixin.dart';
import 'package:sapiensshifter/feature/menu/view_model/menu_view_model.dart';
import 'package:sapiensshifter/feature/menu/view_model/state/menu_view_state.dart';
import 'package:sapiensshifter/product/component/custom_radio/custom_radio_viewer.dart';
import 'package:sapiensshifter/product/component/custom_radio/decoration/custom_radio_decoration.dart';
import 'package:sapiensshifter/product/component/custom_radio/model/custom_radio_model.dart';
import 'package:sapiensshifter/product/models/categories_model/categories_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:shimmer/shimmer.dart';

part 'widget/menu_app_bar.dart';
part 'widget/preview_product_card_grid_list.dart';
part 'widget/menu_add_table_button.dart';
part 'widget/shimmer_preview_product_card.dart';
part 'widget/category_choice_chip.dart';
part 'widget/shimmer_category_chip.dart';

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
        floatingActionButton: AddTableButton(
          onSumbit: () async {
            await viewModel.writeDatabaseTable();
          },
        ),
        appBar: MenuAppBar(
          title: widget.table.tableName,
          onSelected: (category) => viewModel
              .changeCategory(category ?? StringConstant.allCategoryId),
        ),
        body: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sized.normalValue),
      child: BlocBuilder<MenuViewModel, MenuViewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return ShimmerPreviewProductCard();
          }
          return PreviewProductCardGridList(
            productList: state.productList,
            onPressed: (product) async {
              if (product != null) {
                final result =
                    await context.pushRoute(OrderDetailRoute(product: product))
                        as OrderModel?;
                viewModel.addOrder(order: result);
              }
            },
          );
        },
      ),
    );
  }
}
