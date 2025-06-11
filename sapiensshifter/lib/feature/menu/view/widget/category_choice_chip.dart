part of '../menu_view.dart';

class CategoryChoiceChip extends StatelessWidget {
  const CategoryChoiceChip({
    required this.categories,
    required this.onChange,
    super.key,
  });

  final List<CategoriesModel> categories;
  final ValueChanged<String?> onChange;

  Map<String, String> get _categoriesFromWidget {
    final categoriesMap = <String, String>{};
    for (final element in categories) {
      if (element.id == null || element.name == null) continue;
      categoriesMap[element.name!.sapiExt
          .textLocale(LocalizationPathEnum.category)] = element.id!;
    }
    return categoriesMap;
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
    return CustomRadioViewer<String?>.textChip(
      itemMaps: _categoriesFromWidget,
      onChange: onChange,
      radioDecoration: _buildDecoration(context),
    );
  }
}
