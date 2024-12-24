import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/models/nav_bar_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class CustomNavBar extends StatefulWidget {
  const CustomNavBar({required this.items, super.key});
  final List<NavBarItem> items;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  // TODO(kaan): RiverPod ile currentIndexi ayarla.
  int _currentIndex = 1;

  final double _blurCount = 10;
  final double _navBarWidth = 70.w;
  final Color _decorationColor = Colors.black.withOpacity(.2);
  late final Color _isSelectedColor;
  final Color _unSelectedColor = Colors.white60.withOpacity(.5);

  @override
  void didChangeDependencies() {
    _isSelectedColor = context.general.colorScheme.primary;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blurCount, sigmaY: _blurCount),
        child: Container(
          padding: context.padding.low,
          decoration: BoxDecoration(
            borderRadius: context.border.normalBorderRadius,
            color: _decorationColor,
          ),
          width: _navBarWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: generateNavBarButtons(widget.items),
          ),
        ),
      ),
    );
  }

  List<Widget> generateNavBarButtons(List<NavBarItem> items) {
    return items
        .asMap()
        .entries
        .map(
          (entry) => buildNavBarButton(
            icon: entry.value.icon,
            index: entry.key,
            onPress: entry.value.onPress,
          ),
        )
        .toList();
  }

  IconButton buildNavBarButton({
    required IconData icon,
    required int index,
    void Function()? onPress,
  }) {
    final isSelected = _currentIndex == index;
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: isSelected ? _isSelectedColor : _unSelectedColor,
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
        if (isSelected && onPress != null) {
          onPress();
        }
      },
      icon: Icon(icon),
    );
  }
}
