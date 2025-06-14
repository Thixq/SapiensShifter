import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

final class SapiCustomDropDown<T> extends StatelessWidget {
  const SapiCustomDropDown({
    required this.items,
    required this.onSelected,
    this.validator,
    super.key,
    this.hintText,
  })  : _isMulti = false,
        listValidator = null,
        onListChanged = null;

  const SapiCustomDropDown.multiSelect({
    required this.items,
    required this.onListChanged,
    super.key,
    this.hintText,
    this.listValidator,
  })  : _isMulti = true,
        validator = null,
        onSelected = null;

  final bool _isMulti;
  final Map<String, T> items;
  final String? hintText;
  final void Function(T? select)? onSelected;
  final dynamic Function(List<T>)? onListChanged;
  final String? Function(String? value)? validator;
  final String? Function(List<String>)? listValidator;

  @override
  Widget build(BuildContext context) {
    return _isMulti
        ? CustomDropdown<String>.multiSelect(
            listValidator: listValidator,
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_extra.tr(),
            items: items.keys.toList(),
            decoration: _buildDecoration(context),
            onListChanged: (select) {
              final valueList = select
                  .where(items.containsKey)
                  .map((e) => items[e])
                  .toList()
                  .cast<T>();
              onListChanged?.call(valueList);
            },
          )
        : CustomDropdown(
            validator: validator,
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_default.tr(),
            items: items.keys.toList(),
            onChanged: (select) => onSelected?.call(items[select]),
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
