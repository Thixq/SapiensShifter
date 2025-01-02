import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_choice_chip.dart';

class ChoiceChipList<T> extends StatelessWidget {
  ChoiceChipList({
    this.options,
    this.defaultValue,
    super.key,
    this.onSelected,
  });
  final Map<String, T>? options;
  final MapEntry<String, T>? defaultValue;
  final ValueChanged<MapEntry<String, T>>? onSelected;
  late final ValueNotifier<MapEntry<String, T>?>? selectEntry =
      ValueNotifier(defaultValue ?? options?.entries.first);

  @override
  Widget build(BuildContext context) {
    if ((options == null || options!.isEmpty) || selectEntry?.value == null) {
      return const SizedBox.shrink();
    }
    onSelected?.call(selectEntry!.value!);
    return ValueListenableBuilder(
      valueListenable: selectEntry!,
      builder: (context, value, child) {
        return Wrap(
          spacing: 8,
          runSpacing: 4,
          children: List.generate(
            options!.entries.length,
            (index) {
              return CustomChoiceChip<T>(
                onSelected: (value) {
                  selectEntry!.value = value;
                  onSelected?.call(value);
                },
                titleAndValue: options!.entries.toList()[index],
                isSelected:
                    selectEntry!.value!.key == options!.keys.toList()[index],
              );
            },
          ),
        );
      },
    );
  }
}
