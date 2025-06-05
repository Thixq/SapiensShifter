import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

final class CustomChoiceChip<T> extends StatelessWidget {
  const CustomChoiceChip({
    required this.isSelected,
    required this.onSelected,
    required this.titleAndValue,
    required this.localizationPathEnum,
    super.key,
  });
  final MapEntry<String, T> titleAndValue;
  final bool isSelected;
  final ValueChanged<MapEntry<String, T>> onSelected;
  final LocalizationPathEnum? localizationPathEnum;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: context.border.highBorderRadius,
      ),
      side: BorderSide.none,
      backgroundColor: Colors.white,
      label: Text(
        localizationPathEnum != null
            ? titleAndValue.key.sapiExt.textLocale(localizationPathEnum!)
            : titleAndValue.key,
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        onSelected(titleAndValue);
      },
    );
  }
}
