import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/sapi_custom_drop_down/model/sapi_drop_down_model.dart';
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
  final List<SapiDropDownModel<T>> items;
  final String? hintText;
  final void Function(T? select)? onSelected;
  final dynamic Function(List<T>)? onListChanged;
  final String? Function(SapiDropDownModel<T>? value)? validator;
  final String? Function(List<SapiDropDownModel<T>>)? listValidator;

  @override
  Widget build(BuildContext context) {
    return _isMulti
        ? CustomDropdown<SapiDropDownModel<T>>.multiSelect(
            listValidator: listValidator,
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_extra.tr(),
            items: items,
            decoration: _buildDecoration(context),
            onListChanged: (selectList) {
              final valueList =
                  selectList.map((model) => model.value).toList().cast<T>();
              onListChanged?.call(valueList);
            },
          )
        : CustomDropdown(
            validator: validator,
            hintText: hintText ?? LocaleKeys.drop_down_drop_down_default.tr(),
            items: items,
            onChanged: (select) {
              onSelected?.call(select?.value);
            },
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
