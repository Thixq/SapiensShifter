import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/product_price_edit/mixin/product_price_edit_mixin.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/product_price_edit_view_model.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/state/product_price_edit_state.dart';
import 'package:sapiensshifter/product/component/custom_radio/custom_radio_viewer.dart';
import 'package:sapiensshifter/product/component/custom_radio/decoration/custom_radio_decoration.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
part 'widget/product_price_edit_app_bar.dart';
part 'widget/product_price_edit_product_list.dart';
part 'widget/product_price_option_view.dart';
part 'widget/product_price_edit_options.dart';

enum AllSelected { all, none }

@RoutePage()
class ProductPriceEditView extends StatefulWidget {
  const ProductPriceEditView({super.key});

  @override
  State<ProductPriceEditView> createState() => _ProductPriceEditViewState();
}

class _ProductPriceEditViewState extends BaseState<ProductPriceEditView>
    with ProductPriceEditMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: const ProductPriceEditAppBar(),
        body: Column(
          children: [
            BlocBuilder<ProductPriceEditViewModel, ProductPriceEditState>(
              builder: (context, state) => ProductPriceEditOptions(
                allSelecet: state.allSelected,
                allSelecetChange: (value) =>
                    viewModel.selectAllProducts(value ?? false),
                categories: const {
                  'blabla': 'blabla',
                  'sdfdsf': 'asdsaasd',
                  'sadas': 'adasd',
                  'asdasdsdsadasdssadas': 'asd',
                },
                onCategoriesChange: (value) {},
                priceRations: const {
                  'blasadasbla': 'blabla',
                  'sdfdsasdasasdasdf': 'asdsaasd',
                  'sadas': 'adasd',
                  'asdasdsdsadasdssadas': 'asd',
                },
                onPiceRationsChange: (value) {},
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<ProductPriceEditViewModel, ProductPriceEditState>(
                builder: (context, state) {
                  return ProductPriceEditProductList(
                    mainList: state.mainList,
                    isSelected: (product) =>
                        state.selectedList.contains(product),
                    onProductTap: (product) => viewModel.selectProduct(product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
