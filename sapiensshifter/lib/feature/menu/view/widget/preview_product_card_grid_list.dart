part of '../menu_view.dart';

class PreviewProductCardGridList extends StatelessWidget {
  const PreviewProductCardGridList({
    required this.productList,
    required this.onPressed,
    super.key,
  });

  final List<ProductModel> productList;
  final void Function(ProductModel? prdouctId) onPressed;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.sized.normalValue,
        mainAxisSpacing: context.sized.normalValue,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return PreviewProductCard(
          productModel: productList[index],
          onPressed: onPressed,
        );
      },
    );
  }
}
