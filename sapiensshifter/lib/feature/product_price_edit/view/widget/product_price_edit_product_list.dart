part of '../product_price_edit_view.dart';

class ProductPriceEditProductList extends StatelessWidget {
  const ProductPriceEditProductList({
    required this.mainList,
    required this.isSelected,
    required this.onProductTap,
    super.key,
  });
  final List<ProductModel> mainList;
  final bool Function(ProductModel product) isSelected;
  final void Function(ProductModel product) onProductTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          context.sized.emptySizedHeightBoxLow,
      itemCount: mainList.length,
      itemBuilder: (context, index) {
        final productModel = mainList[index];
        return PriceEditingCard(
          productModel: productModel,
          isSelected: isSelected(productModel),
          onPress: onProductTap,
        );
      },
    );
  }
}
