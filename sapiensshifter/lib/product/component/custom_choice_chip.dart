import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

final class CustomChoiceChip<T> extends StatelessWidget {
  const CustomChoiceChip({
    required this.isSelected,
    required this.onSelected,
    required this.titleAndValue,
    super.key,
  });
  final MapEntry<String, T> titleAndValue;
  final bool isSelected;
  final ValueChanged<MapEntry<String, T>> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: context.border.highBorderRadius,
      ),
      side: BorderSide.none,
      backgroundColor: Colors.white,
      label: Text(titleAndValue.key),
      selected: isSelected,
      onSelected: (bool selected) {
        onSelected(titleAndValue);
      },
    );
  }
}
