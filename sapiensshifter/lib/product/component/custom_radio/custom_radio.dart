import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    required this.svgPath,
    required this.onPress,
    required this.value,
    required this.selecetedColor,
    this.isSelected = false,
    super.key,
    this.backgroundColor = Colors.white,
    this.size = 24,
  });
  final T value;
  final Color backgroundColor;
  final Color selecetedColor;
  final String svgPath;
  final double size;
  final ValueChanged<T> onPress;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      child: InkWell(
        splashColor: context.general.appTheme.splashColor,
        highlightColor: context.general.appTheme.highlightColor,
        borderRadius: BorderRadius.circular(size),
        onTap: () => onPress(value),
        child: Ink(
          padding: EdgeInsets.all(context.sized.lowValue),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? selecetedColor : backgroundColor,
          ),
          child: SvgAssetBuilder(
            builderSize: Size(size, size),
            svgPath: svgPath,
          ),
        ),
      ),
    );
  }
}
