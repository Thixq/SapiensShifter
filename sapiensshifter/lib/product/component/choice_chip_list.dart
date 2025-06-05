import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_choice_chip.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

final class ChoiceChipList<T> extends StatelessWidget {
  ChoiceChipList({
    this.localizationPathEnum,
    this.options,
    this.defaultValue,
    this.isWrap = false,
    super.key,
    this.onSelected,
  });
  final bool isWrap;
  final Map<String, T>? options;
  final MapEntry<String, T>? defaultValue;
  final ValueChanged<MapEntry<String, T>>? onSelected;
  late final ValueNotifier<MapEntry<String, T>?>? selectEntry =
      ValueNotifier(defaultValue ?? options?.entries.first);
  final LocalizationPathEnum? localizationPathEnum;

  @override
  Widget build(BuildContext context) {
    if ((options == null || options!.isEmpty) || selectEntry?.value == null) {
      return const SizedBox.shrink();
    }
    onSelected?.call(selectEntry!.value!);
    return ValueListenableBuilder(
      valueListenable: selectEntry!,
      builder: (context, value, child) {
        return isWrap
            ? Wrap(
                runSpacing: 4,
                children: _buildChipList(context),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildChipList(context),
                ),
              );
      },
    );
  }

  List<Widget> _buildChipList(BuildContext context) {
    return List.generate(
      options!.entries.length,
      (index) {
        return Padding(
          padding: EdgeInsets.only(right: context.sized.lowValue),
          child: CustomChoiceChip<T>(
            onSelected: (value) {
              selectEntry!.value = value;
              onSelected?.call(value);
            },
            titleAndValue: options!.entries.toList()[index],
            isSelected:
                selectEntry!.value!.key == options!.keys.toList()[index],
            localizationPathEnum: localizationPathEnum,
          ),
        );
      },
    );
  }
}
