part of '../product_price_edit_view.dart';

class ProductPriceOptionView<T> extends StatelessWidget {
  const ProductPriceOptionView({
    required this.options,
    required this.onChange,
    super.key,
  });

  final Map<String, T> options;
  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) {
    return CustomRadioViewer<T>.textChip(
      itemMaps: options,
      onChange: onChange,
      isWrap: true,
      radioDecoration: _buildDecoration(context),
    );
  }

  CustomRadioDecoration _buildDecoration(BuildContext context) {
    return CustomRadioDecoration(
      selectedColor: context.general.colorScheme.primary,
      padding: EdgeInsets.symmetric(
        horizontal: context.sized.normalValue,
        vertical: context.sized.lowValue,
      ),
      borderRadius: BorderRadius.circular(context.sized.normalValue),
    );
  }
}
