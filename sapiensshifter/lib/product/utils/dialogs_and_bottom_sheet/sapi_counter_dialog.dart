import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class SapiCounterDialog extends StatefulWidget {
  const SapiCounterDialog({
    this.titleName,
    super.key,
  });
  final String? titleName;

  static Future<int?> show(BuildContext context, {String? titleName}) =>
      showDialog(
        context: context,
        builder: (context) {
          return SapiCounterDialog(
            titleName: titleName,
          );
        },
      );

  @override
  State<SapiCounterDialog> createState() => _SapiCounterDialogState();
}

class _SapiCounterDialogState extends State<SapiCounterDialog> {
  int _count = 0;
  late final TextStyle? _buttonTextStyle;
  late final TextStyle? _titleTextStyle;

  int get _minMaxCount => _count.clamp(0, 8);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textTheme = context.general.textTheme;
    _buttonTextStyle = textTheme.labelMedium;
    _titleTextStyle = textTheme.titleMedium;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: context.border.roundedRectangleAllBorderNormal,
      child: IntrinsicHeight(
        child: Container(
          padding: context.padding.normal,
          child: Column(
            children: [
              title,
              context.sized.emptySizedHeightBoxLow3x,
              _buildPeopleCount(context, _count),
              context.sized.emptySizedHeightBoxLow3x,
              _buildPeopleCountButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildPeopleCountButton(
    BuildContext context,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: FilledButton.tonal(
        onPressed: () {
          context.route.pop(_count);
        },
        child: Text(
          LocaleKeys.confirm.tr(),
          style: _buttonTextStyle,
        ),
      ),
    );
  }

  Row _buildPeopleCount(BuildContext context, int peopleCount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconButton(
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
        _buildIconButton(
          icon: Icons.add,
          onPressed: () => setState(() {
            _count++;
            _count = _minMaxCount;
          }),
        ),
      ],
    );
  }

  IconButton _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton.filled(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          context.border.roundedRectangleAllBorderNormal,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }

  Text get title => Text(
        widget.titleName ?? 'Null',
        style: _titleTextStyle,
      );
}
