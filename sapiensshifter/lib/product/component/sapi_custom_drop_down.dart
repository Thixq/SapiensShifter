import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class SapiCustomDropDown<T> extends StatelessWidget {
  const SapiCustomDropDown({
    required this.items,
    required this.onSelected,
    this.isMulti = false,
    super.key,
    this.hintText,
  });
  final bool isMulti;
  final Map<String, T> items;
  final String? hintText;
  final void Function(dynamic select) onSelected;

  @override
  Widget build(BuildContext context) {
    return isMulti
        ? CustomDropdown.multiSelect(
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_extra.tr(),
            items: items.keys.toList(),
            decoration: _buildDecoration(context),
            onListChanged: (select) {
              final valueList =
                  select.where(items.containsKey).map((e) => items[e]).toList();
              onSelected(valueList);
            },
          )
        : CustomDropdown(
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_default.tr(),
            items: items.keys.toList(),
            onChanged: (select) => onSelected(items[select]),
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
