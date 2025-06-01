import 'package:flutter/material.dart';

class SeparatorListWidget<T extends Widget> extends StatelessWidget {
  const SeparatorListWidget({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.separator,
    super.key,
    this.axis = Axis.vertical,
  });
  final List<T> children;
  final Widget? separator;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    switch (axis) {
      case Axis.horizontal:
        return Row(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: _insertSeparators(children),
        );
      case Axis.vertical:
        return Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          children: _insertSeparators(children),
        );
    }
  }

  List<Widget> _insertSeparators(List<Widget> items) {
    if (separator != null) {
      final finalWidgets = <Widget>[];
      for (var i = 0; i < items.length; i++) {
        finalWidgets.add(items[i]);
        if (i < items.length - 1) {
          finalWidgets.add(separator!); // Son elemana separator eklemiyoruz
        }
      }
      return finalWidgets;
    }
    return items;
  }
}
