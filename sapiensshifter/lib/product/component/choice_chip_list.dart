import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_choice_chip.dart';

final class ChoiceChipList<T> extends StatelessWidget {
  ChoiceChipList({
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
                      isSelected: selectEntry!.value!.key ==
                          options!.keys.toList()[index],
                    );
                  },
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    options!.entries.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CustomChoiceChip<T>(
                          onSelected: (value) {
                            selectEntry!.value = value;
                            onSelected?.call(value);
                          },
                          titleAndValue: options!.entries.toList()[index],
                          isSelected: selectEntry!.value!.key ==
                              options!.keys.toList()[index],
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
