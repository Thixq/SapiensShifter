part of '../product_price_edit_view.dart';

class ProductPriceEditOptions extends StatelessWidget {
  const ProductPriceEditOptions({
    required this.categories,
    required this.onCategoriesChange,
    required this.priceRations,
    required this.onpPiceRationsChange,
    super.key,
  });

  final Map<String, String> categories;
  final ValueChanged<String> onCategoriesChange;
  final Map<String, String> priceRations;
  final ValueChanged<String> onpPiceRationsChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductPriceOptionView(
          options: categories,
          onChange: onCategoriesChange,
        ),
        const Divider(),
        ProductPriceOptionView(
          options: priceRations,
          onChange: onpPiceRationsChange,
        ),
        CheckboxListTile.adaptive(
          value: false,
          onChanged: (value) {},
          title: const Text('data'),
        ),
      ],
    );
  }
}
