part of '../menu_view.dart';

class CategoryChoiceChip extends StatelessWidget {
  const CategoryChoiceChip({
    required this.categories,
    required this.onChange,
    super.key,
  });

  final List<CategoriesModel> categories;
  final ValueChanged<String?> onChange;

  List<CustomRadioModel<String?>> get _categoriesFromWidget {
    return categories
        .map(
          (e) => CustomRadioModel<String?>(
            widget:
                Text(e.name.sapiExt.textLocale(LocalizationPathEnum.category)),
            value: e.id,
          ),
        )
        .toList()
        .cast<CustomRadioModel<String?>>();
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

  @override
  Widget build(BuildContext context) {
    return CustomRadioViewer<String?>(
      itemList: _categoriesFromWidget,
      onChange: onChange,
      isWrap: false,
      radioDecoration: _buildDecoration(context),
    );
  }
}
