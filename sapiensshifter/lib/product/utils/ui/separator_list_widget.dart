import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class SeparatorListWidget<T extends Widget> extends StatelessWidget {
  SeparatorListWidget({
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onListChanged,
    this.children,
    this.separator,
    this.isDismissible = false,
    super.key,
    this.axis = Axis.vertical,
  });

  final List<T>? children;
  final Widget? separator;
  final bool isDismissible;
  final ValueChanged<List<T>>? onListChanged;
  late final ValueNotifier<List<T>> dynamicList =
      ValueNotifier<List<T>>(children ?? []);
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis axis;

  void _selecetItemDelete(int index) {
    dynamicList.value = List.from(dynamicList.value)..removeAt(index);
    onListChanged?.call(dynamicList.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dynamicList,
      builder: (context, value, child) {
        switch (axis) {
          case Axis.horizontal:
            return Row(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              children: _addWidget(context),
            );
          case Axis.vertical:
            return Column(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              children: _addWidget(context),
            );
        }
      },
    );
  }

  List<Widget> _addWidget(BuildContext context) {
    if (children == null || children!.isEmpty) {
      return children ?? [];
    }
    final dismissibleWidgets = _dismissibleObjectConvert(context);
    final widgets = _widgetList(context);
    return _insertSeparators(isDismissible ? dismissibleWidgets : widgets);
  }

  List<Widget> _dismissibleObjectConvert(BuildContext context) {
    final dismissibleWidgets = List<Widget>.generate(
      dynamicList.value.length,
      (index) {
        return Slidable(
          key: UniqueKey(),
          endActionPane: _buildAction(index, context),
          child: dynamicList.value[index],
        );
      },
    );
    return dismissibleWidgets;
  }

  ActionPane _buildAction(int index, BuildContext context) {
    return ActionPane(
      motion: const StretchMotion(),
      dismissible: DismissiblePane(
        onDismissed: () {
          _selecetItemDelete(index);
        },
      ),
      children: [
        CustomSlidableAction(
          onPressed: (BuildContext context) {
            _selecetItemDelete(index);
          },
          backgroundColor: context.general.colorScheme.primary,
          foregroundColor: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: context.border.normalRadius,
            bottomLeft: context.border.normalRadius,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  LocaleKeys.delete.tr(),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _widgetList(BuildContext context) {
    final dismissibleWidgets = List<Widget>.generate(
      dynamicList.value.length,
      (index) {
        return dynamicList.value[index];
      },
    );
    return dismissibleWidgets;
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
