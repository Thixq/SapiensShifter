import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class SapiSegmentButton extends StatefulWidget {
  const SapiSegmentButton({super.key});

  @override
  State<SapiSegmentButton> createState() => _SapiSegmentButtonState();
}

class _SapiSegmentButtonState extends State<SapiSegmentButton> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        10,
        (index) {
          return SegmentTabItem(
            index: index,
          );
        },
      ),
    );
  }
}

class SegmentTabItem<T> extends StatelessWidget {
  const SegmentTabItem({
    required this.index,
    this.isSelect = false,
    this.select,
    super.key,
  });
  final int index;
  final bool isSelect;
  final ValueChanged<MapEntry<String, T>>? select;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(
        borderRadius: context.border.normalBorderRadius,
      ),
      showCheckmark: false,
      label: const Text('data'),
      selected: false,
      onSelected: (value) {},
    );
  }
}
