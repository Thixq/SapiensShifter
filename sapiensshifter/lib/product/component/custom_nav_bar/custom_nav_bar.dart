import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part './model/custom_nav_bar_item_model.dart';

final class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    required this.items,
    required this.onChange,
    this.initalIndex = 0,
    super.key,
  });
  final List<NavBarItem> items;
  final int initalIndex;
  final ValueChanged<int> onChange;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late int _currentIndex;

  final double _blurCount = 10;
  final Color _decorationColor = Colors.white.withValues(alpha: .2);
  final Color _unSelectedColor = Colors.white.withValues(alpha: .5);

  @override
  void initState() {
    _currentIndex = widget.initalIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.sized.normalValue),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blurCount, sigmaY: _blurCount),
        child: Container(
          padding: context.padding.low,
          color: _decorationColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _generateNavBarButtons(widget.items),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateNavBarButtons(List<NavBarItem> items) {
    return items
        .asMap()
        .entries
        .map(
          (entry) => _buildNavBarButton(
            icon: entry.value.icon,
            index: entry.key,
            onPress: entry.value.onPress,
          ),
        )
        .toList();
  }

  IconButton _buildNavBarButton({
    required IconData icon,
    required int index,
    void Function()? onPress,
  }) {
    final isSelected = _currentIndex == index;
    final selectedColor = context.general.colorScheme.primary;
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: isSelected ? selectedColor : _unSelectedColor,
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
          widget.onChange(index);
        });
        if (isSelected && onPress != null) {
          onPress();
        }
      },
      icon: Icon(icon),
    );
  }
}
