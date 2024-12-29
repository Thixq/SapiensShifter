import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class SeparatorColumn<T extends Widget> extends StatelessWidget {
  SeparatorColumn({
    this.onListChanged,
    this.widgets,
    this.separator,
    super.key,
  });

  final List<T>? widgets;
  final Widget? separator;
  final ValueChanged<List<T>>? onListChanged;
  late final ValueNotifier<List<T>> dynamicList =
      ValueNotifier<List<T>>(widgets ?? []);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dynamicList,
      builder: (context, value, child) => Column(
        children: _addWidget(context),
      ),
    );
  }

  List<Widget> _addWidget(BuildContext context) {
    if (widgets == null || widgets!.isEmpty) {
      return widgets ?? [];
    }
    final dismissibleWidgets = _dismissibleObjectConvert(context);
    return _insertSeparators(dismissibleWidgets);
  }

  List<Widget> _dismissibleObjectConvert(BuildContext context) {
    final dismissibleWidgets = List<Widget>.generate(
      dynamicList.value.length,
      (index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            dynamicList.value = List.from(dynamicList.value)..removeAt(index);
            onListChanged?.call(dynamicList.value);
          },
          background: _buildDismissibleBackground(context),
          child: dynamicList.value[index],
        );
      },
    );
    return dismissibleWidgets;
  }

  Container _buildDismissibleBackground(BuildContext context) {
    return Container(
      padding: context.padding.medium,
      decoration: BoxDecoration(
        color: context.general.colorScheme.primary,
        borderRadius: context.border.normalBorderRadius,
      ),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
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
