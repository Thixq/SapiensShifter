import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/custom_radio/decoration/custom_radio_decoration.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    required this.widget,
    required this.onPress,
    required this.value,
    this.isSelected = false,
    this.radioDecoration = const CustomRadioDecoration(),
    super.key,
  });

  final T value;
  final CustomRadioDecoration radioDecoration;
  final Widget widget;
  final ValueChanged<T> onPress;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(value),
      borderRadius: radioDecoration.borderRadius,
      splashColor: context.general.appTheme.splashColor,
      highlightColor: context.general.appTheme.highlightColor,
      child: Container(
        padding: radioDecoration.padding,
        decoration: BoxDecoration(
          borderRadius: radioDecoration.borderRadius,
          color: isSelected
              ? radioDecoration.selectedColor
              : radioDecoration.backgroundColor,
        ),
        child: widget,
      ),
    );
  }
}
