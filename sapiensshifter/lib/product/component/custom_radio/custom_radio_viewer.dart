import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_radio/custom_radio.dart';
import 'package:sapiensshifter/product/component/custom_radio/model/custom_radio_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/ui/separator_list_widget.dart';

class CustomRadioViewer<T> extends StatefulWidget {
  const CustomRadioViewer({
    required this.itemList,
    required this.onChange,
    this.spacing = 16,
    this.itemSize = 24,
    this.axis = Axis.horizontal,
    super.key,
  });

  final Axis axis;
  final List<CustomRadioModel<T>> itemList;
  final ValueChanged<T> onChange;
  final double itemSize;
  final double spacing;
  @override
  State<CustomRadioViewer<T>> createState() => _CustomRadioViewerState<T>();
}

class _CustomRadioViewerState<T> extends State<CustomRadioViewer<T>> {
  late CustomRadioModel<T> _currentItem;
  @override
  void initState() {
    _currentItem = widget.itemList.first;
    widget.onChange(_currentItem.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatorListWidget(
      mainAxisSize: MainAxisSize.min,
      axis: widget.axis,
      separator: widget.axis == Axis.horizontal
          ? SizedBox(width: widget.spacing)
          : SizedBox(height: widget.spacing),
      children: List<CustomRadio<T>>.generate(
        widget.itemList.length,
        (index) {
          return CustomRadio(
            size: widget.itemSize,
            svgPath: widget.itemList[index].svgPath,
            onPress: (value) {
              setState(() {
                _currentItem = _currentItem.copyWith(value: value);
                widget.onChange(value);
              });
            },
            isSelected: widget.itemList[index].value == _currentItem.value,
            value: widget.itemList[index].value,
            selecetedColor: context.general.colorScheme.primary,
          );
        },
      ),
    );
  }
}
