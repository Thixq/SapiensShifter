part of '../order_detail_view.dart';

class Title extends StatelessWidget {
  const Title({
    required this.productModel,
    super.key,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.sized.lowValue,
          horizontal: context.sized.normalValue,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 48.spa,
              child: AspectRatio(
                aspectRatio: 5 / 6,
                child: ImageBuilder(
                  fit: BoxFit.fill,
                  borderRadius: BorderRadius.circular(16),
                  imageUrl: productModel.imagePath,
                ),
              ),
            ),
            context.sized.emptySizedHeightBoxLow,
            Text(
              productModel.description ?? StringConstant.nullString.tr(),
              style: context.general.textTheme.bodySmall,
              textAlign: TextAlign.justify,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
