import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/product_price_edit/mixin/product_price_edit_mixin.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/mixin/func/price_editing.dart';

part 'widget/product_price_edit_app_bar.dart';

@RoutePage()
class ProductPriceEditView extends StatefulWidget {
  const ProductPriceEditView({super.key});

  @override
  State<ProductPriceEditView> createState() => _ProductPriceEditViewState();
}

class _ProductPriceEditViewState extends BaseState<ProductPriceEditView>
    with ProductPriceEditMixin, PriceEditingMixin {
  late final List<ProductModel> mainList;
  late Set<ProductModel> selectedList;

  @override
  void initState() {
    selectedList = <ProductModel>{};
    mainList = List.generate(
      12,
      (index) => ProductModel(
        id: 'id$index',
        price: index.toDouble(),
        imagePath: 'https://picsum.photos/200/300?random=$index',
      ),
    );
    super.initState();
  }

  void _onSave() {
    setState(() {
      findAndOperate(
        mainList: mainList,
        selectedList: selectedList,
        operations: PriceOperations.PERCENTAGE,
        value: .10,
      );
      selectedList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductPriceEditAppBar(
        onSave: _onSave,
      ),
      body: _buildList(),
    );
  }

  ListView _buildList() {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          context.sized.emptySizedHeightBoxLow,
      itemCount: mainList.length,
      itemBuilder: (context, index) {
        final productModel = mainList[index];
        return PriceEditingCard(
          productModel: productModel,
          isSelected: selectedList.contains(productModel),
          onPress: (productModel) {
            setState(() {
              selectedList.contains(productModel)
                  ? selectedList.remove(productModel)
                  : selectedList.add(productModel);
            });
          },
        );
      },
    );
  }
}
