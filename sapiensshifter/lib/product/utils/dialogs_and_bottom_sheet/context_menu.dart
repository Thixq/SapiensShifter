import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/exception/exceptions/general_exception.dart';
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
      position: _getPosition(key),
      context: key.currentContext!,
      items: items,
    );
  }

  static RelativeRect? _getPosition(GlobalKey key) {
    if (key.currentContext != null) {
      if (key.currentContext!.mounted) {
        final renderObject = _getOffset(key);
        return RelativeRect.fromRect(
          Rect.fromPoints(
            renderObject.offset.translate(16.spa, 24.spa), // Sol üst köşe
            renderObject.offset.translate(
              (renderObject.size?.width ?? 0) + 16.spa,
              (renderObject.size?.height ?? 0) + 16.spa,
            ), // Sağ alt köşe
          ),
          Offset.zero &
              MediaQuery.of(key.currentContext!).size, // Ekranın tamamı
        );
      }
    } else {
      throw GeneralException('code');
    }
    return null;
  }

  static ({Size? size, Offset offset}) _getOffset(GlobalKey key) {
    final context = key.currentContext!;
    final size = context.size;
    final objectRenderBox = context.findRenderObject()! as RenderBox;
    final offset = objectRenderBox.localToGlobal(Offset.zero);
    return (size: size, offset: offset);
  }
}
