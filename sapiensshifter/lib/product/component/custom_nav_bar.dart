import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/constant/color_constant.dart';
import 'package:sapiensshifter/product/models/nav_bar_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({required this.items, super.key});
  final List<NavBarItem> items;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  // TODO(kaan): RiverPod ile currentIndexi ayarla.
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: context.padding.low,
          decoration: BoxDecoration(
            borderRadius: context.border.normalBorderRadius,
            color: Colors.black.withOpacity(.2),
          ),
          width: 70.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavBarList(widget.items),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavBarList(List<NavBarItem> items) {
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
    final isSelect = _currentIndex == index;
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: isSelect
            ? ColorConstant.primaryColor
            : Colors.white60.withOpacity(.5),
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
        if (isSelect && onPress != null) {
          onPress();
        }
      },
      icon: Icon(icon),
    );
  }
}
