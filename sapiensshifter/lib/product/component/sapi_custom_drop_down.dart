import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

final class SapiCustomDropDown<T, R, V> extends StatelessWidget {
  const SapiCustomDropDown({
    required this.items,
    required this.onSelected,
    this.validator,
    this.isMulti = false,
    super.key,
    this.hintText,
    this.controller,
    this.multiSelectController,
  });

  final bool isMulti;
  final Map<String, T> items;
  final String? hintText;
  final void Function(R select) onSelected;
  final String? Function(V? value)? validator;
  final SingleSelectController<T?>? controller;
  final MultiSelectController<T>? multiSelectController;

  @override
  Widget build(BuildContext context) {
    return isMulti
        ? CustomDropdown.multiSelect(
            multiSelectController: multiSelectController,
            listValidator: (p0) {
              if (validator != null) {
                return validator!(p0 as V);
              }
              return null;
            },
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_extra.tr(),
            items: items.keys.toList(),
            decoration: _buildDecoration(context),
            onListChanged: (select) {
              final valueList = select
                  .where(items.containsKey)
                  .map((e) => items[e])
                  .toList()
                  .cast<T>();
              onSelected(valueList as R);
            },
          )
        : CustomDropdown(
            controller: controller,
            validator: (p0) {
              if (validator != null) {
                return validator!(p0 as V);
              }
              return null;
            },
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_default.tr(),
            items: items.keys.toList(),
            onChanged: (select) => onSelected(items[select] as R),
            decoration: _buildDecoration(context),
          );
  }

  CustomDropdownDecoration _buildDecoration(BuildContext context) {
    return CustomDropdownDecoration(
      errorStyle: context.general.textTheme.bodySmall!.copyWith(
        color: context.general.colorScheme.error,
      ),
      closedErrorBorderRadius: BorderRadius.circular(context.sized.normalValue),
      headerStyle: context.general.textTheme.titleMedium,
      listItemStyle: context.general.textTheme.bodyMedium,
      closedBorderRadius: BorderRadius.circular(context.sized.normalValue),
      closedBorder: Border.all(),
      closedFillColor: Colors.transparent,
      hintStyle: context.general.textTheme.titleMedium,
    );
  }
}
