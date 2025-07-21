part of '../menu_view.dart';

class ShimmerPreviewProductCard extends StatelessWidget {
  ShimmerPreviewProductCard({super.key});

  final smmiherList = List.generate(
    6,
    (index) => const ProductModel(),
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.sized.normalValue,
        mainAxisSpacing: context.sized.normalValue,
      ),
      itemCount: smmiherList.length,
      itemBuilder: (context, index) {
        return Shimmer(
          gradient:
              LinearGradient(colors: [Colors.grey.shade400, Colors.white]),
          child: PreviewProductCard(
            productModel: smmiherList[index],
            onPressed: (productId) {},
          ),
        );
      },
    );
  }
}
