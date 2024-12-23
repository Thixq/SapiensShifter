import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class SapiCustomDropDown<T> extends StatelessWidget {
  const SapiCustomDropDown({
    required this.items,
    required this.onSelect,
    this.isMulti = false,
    super.key,
    this.hintText,
  });
  final bool isMulti;
  final Map<String, T> items;
  final String? hintText;
  final void Function(T? select) onSelect;

  @override
  Widget build(BuildContext context) {
    return isMulti
        ? CustomDropdown.multiSelect(
            hintText: hintText,
            items: items.keys.toList(),
            decoration: _buildDecoration(context),
            onListChanged: (select) {
              final valueList =
                  select.where(items.containsKey).map((e) => items[e]).toList();
              onSelect(valueList as T?);
            },
          )
        : CustomDropdown(
            hintText: hintText,
            items: items.keys.toList(),
            onChanged: (select) => onSelect(items[select]),
            decoration: _buildDecoration(context),
          );
  }

  CustomDropdownDecoration _buildDecoration(BuildContext context) {
    return CustomDropdownDecoration(
      headerStyle: context.general.textTheme.titleMedium,
      listItemStyle: context.general.textTheme.bodyMedium,
      closedBorderRadius: context.border.normalBorderRadius,
      closedBorder: Border.all(),
      closedFillColor: Colors.transparent,
      hintStyle: context.general.textTheme.titleMedium,
    );
  }
}
