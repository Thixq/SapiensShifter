import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

class SapiCounterDialog extends StatefulWidget {
  const SapiCounterDialog({
    required this.titleName,
    required this.done,
    super.key,
  });

  final String titleName;
  final void Function(String, int) done;

  static Future<int?> show(
    BuildContext context, {
    required String titleName,
    required void Function(String title, int count) done,
  }) =>
      showDialog(
        context: context,
        builder: (context) {
          return SapiCounterDialog(
            titleName: titleName,
            done: done,
          );
        },
      );

  @override
  State<SapiCounterDialog> createState() => _SapiCounterDialogState();
}

class _SapiCounterDialogState extends State<SapiCounterDialog> {
  late int _count = 0;
  late final TextStyle? _buttonTextStyle;

  int get _minMaxCount => _count.clamp(0, 8);
  late String _title;

  @override
  void initState() {
    _count = 0;
    _title = widget.titleName;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textTheme = context.general.textTheme;
    _buttonTextStyle = textTheme.labelMedium;
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
              EditableTextFieldWithIcon(
                initialText: widget.titleName,
                onSubmitted: (value) {
                  _title = value;
                },
              ),
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
          context.route.pop();
          widget.done(_title, _count);
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
}
