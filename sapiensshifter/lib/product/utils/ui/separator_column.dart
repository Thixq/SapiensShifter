import 'package:flutter/material.dart';

// TODO(kaan): Dismissible olayına bak.
class SeparatorColumn extends StatelessWidget {
  const SeparatorColumn({
    this.widgets,
    this.separator,
    super.key,
  });
  final List<Widget>? widgets;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _addSeparators,
    );
  }

  List<Widget> get _addSeparators {
    if (widgets == null || widgets!.isEmpty || separator == null) {
      return widgets ?? [];
    }

    return [
      for (int i = 0; i < widgets!.length; i++) ...[
        widgets![i],
        if (i < widgets!.length - 1) separator!,
      ],
    ];
  }
}
