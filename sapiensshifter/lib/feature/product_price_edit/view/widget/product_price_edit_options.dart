part of '../product_price_edit_view.dart';

class ProductPriceEditOptions extends StatelessWidget {
  const ProductPriceEditOptions({
    required this.categories,
    required this.onCategoriesChange,
    required this.priceRations,
    required this.onPiceRationsChange,
    required this.allSelecet,
    required this.allSelecetChange,
    super.key,
  });

  final Map<String, String> categories;
  final ValueChanged<String> onCategoriesChange;
  final Map<String, String> priceRations;
  final ValueChanged<String> onPiceRationsChange;
  final bool allSelecet;
  final ValueChanged<bool?> allSelecetChange;

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
          onChange: onPiceRationsChange,
        ),
        CheckboxListTile.adaptive(
          value: allSelecet,
          onChanged: allSelecetChange,
          title: Text(
            (allSelecet ? LocaleKeys.remove_all : LocaleKeys.select_all).tr(),
          ),
        ),
      ],
    );
  }
}
