import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/export_dependency_package/component_export_package.dart';

class SapiCounterDialog extends StatefulWidget {
  const SapiCounterDialog({
    required this.titleName,
    required this.buttonText,
    required this.onPressed,
    super.key,
  });
  final String titleName;
  final String buttonText;
  final void Function(int value) onPressed;

  @override
  State<SapiCounterDialog> createState() => _SapiCounterState();
}

class _SapiCounterState extends State<SapiCounterDialog> {
  int _count = 0;
  int get _minMaxCount => _count.clamp(0, 8);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: context.padding.normal,
        child: Column(
          children: [
            title,
            context.sized.emptySizedHeightBoxLow3x,
            peopleCount(context, _count),
            context.sized.emptySizedHeightBoxLow3x,
            peopleCountButton(context, widget.onPressed),
          ],
        ),
      ),
    );
  }

  Align peopleCountButton(
    BuildContext context,
    void Function(int peopleCount) onPreesed,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: FilledButton.tonal(
        onPressed: () {
          onPreesed(_count);
          context.route.pop();
        },
        child: Text(
          widget.buttonText,
          style: context.general.textTheme.labelMedium,
        ),
      ),
    );
  }

  Row peopleCount(BuildContext context, int peopleCount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        iconButton(
          icon: Icons.remove,
          onPressed: () => setState(() {
            _count--;
            _count = _minMaxCount;
          }),
        ),
        Padding(
          padding: context.padding.horizontalNormal,
          child: Text(peopleCount.toString().padLeft(2, '0')),
        ),
        iconButton(
          icon: Icons.add,
          onPressed: () => setState(() {
            _count++;
            _count = _minMaxCount;
          }),
        ),
      ],
    );
  }

  IconButton iconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton.filled(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: context.border.lowBorderRadius,
          ),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }

  Text get title => Text(
        widget.titleName,
        style: context.general.textTheme.titleMedium,
      );
}
