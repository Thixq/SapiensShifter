import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContextMenu {
  static Future<T?> show<T>({
    required GlobalKey key,
    required List<PopupMenuEntry<T>> items,
  }) {
    return showMenu<T>(
      clipBehavior: Clip.hardEdge,
      menuPadding: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.spa)),
      position: _getDynamicPosition(key, items.length),
      context: key.currentContext!,
      items: items,
    );
  }

  static RelativeRect _getDynamicPosition(GlobalKey key, int itemCount) {
    final context = key.currentContext!;
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    const itemHeight = 48;
    const itemWidth = 200;
    final menuHeight = itemHeight * itemCount;
    const menuWidth = itemWidth;

    final spaceAbove = offset.dy;
    final spaceBelow = screenSize.height - (offset.dy + size.height);
    final spaceLeft = offset.dx;
    final spaceRight = screenSize.width - (offset.dx + size.width);

    var left = offset.dx;
    var top = offset.dy + size.height;

    // Uygun konumu belirleme
    if (spaceBelow >= menuHeight) {
      top = offset.dy + size.height;
    } else if (spaceAbove >= menuHeight) {
      top = offset.dy - menuHeight;
    } else {
      top = offset.dy + size.height;
    }

    if (spaceRight >= menuWidth) {
      left = offset.dx;
    } else if (spaceLeft >= menuWidth) {
      left = offset.dx - menuWidth + size.width;
    } else {
      left = offset.dx;
    }

    return RelativeRect.fromLTRB(
      left,
      top,
      screenSize.width - left - menuWidth,
      screenSize.height - top - menuHeight,
    );
  }
}
