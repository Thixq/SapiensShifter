import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_radio/custom_radio.dart';
import 'package:sapiensshifter/product/component/custom_radio/decoration/custom_radio_decoration.dart';
import 'package:sapiensshifter/product/component/custom_radio/model/custom_radio_model.dart';
import 'package:sapiensshifter/product/utils/ui/separator_list_widget.dart';

class CustomRadioViewer<T> extends StatefulWidget {
  const CustomRadioViewer({
    required this.itemList,
    required this.onChange,
    this.spacing = 16,
    this.axis = Axis.horizontal,
    this.isWrap = true,
    super.key,
    this.radioDecoration = const CustomRadioDecoration(),
  });

  final Axis axis;
  final bool isWrap;
  final List<CustomRadioModel<T>> itemList;
  final ValueChanged<T> onChange;
  final CustomRadioDecoration radioDecoration;

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
    return widget.isWrap ? _buildWrapList(context) : _buildRadioList(context);
  }

  Wrap _buildWrapList(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.spacing,
      direction: widget.axis,
      children: _buildRadioItemList(context),
    );
  }

  SingleChildScrollView _buildRadioList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: widget.axis,
      child: SeparatorListWidget(
        mainAxisSize: MainAxisSize.min,
        axis: widget.axis,
        separator: widget.axis == Axis.horizontal
            ? SizedBox(width: widget.spacing)
            : SizedBox(height: widget.spacing),
        children: _buildRadioItemList(context),
      ),
    );
  }

  List<CustomRadio<dynamic>> _buildRadioItemList(BuildContext context) {
    return List<CustomRadio<T>>.generate(
      widget.itemList.length,
      (index) {
        return CustomRadio(
          widget: widget.itemList[index].widget,
          onPress: (value) {
            setState(() {
              _currentItem = _currentItem.copyWith(value: value);
              widget.onChange(value);
            });
          },
          isSelected: widget.itemList[index].value == _currentItem.value,
          value: widget.itemList[index].value,
          radioDecoration: widget.radioDecoration,
        );
      },
    );
  }
}
