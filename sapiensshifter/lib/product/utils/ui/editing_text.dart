import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart'
    show ContextExtension, SizedBoxExtension;

class EditableTextFieldWithIcon extends StatefulWidget {
  const EditableTextFieldWithIcon({
    required this.initialText,
    required this.onSubmitted,
    super.key,
  });
  final String initialText;
  final ValueChanged<String> onSubmitted;

  @override
  State<EditableTextFieldWithIcon> createState() =>
      _EditableTextFieldWithIconState();
}

class _EditableTextFieldWithIconState extends State<EditableTextFieldWithIcon> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _saveChanges();
    }
  }

  void _toggleEditing() {
    setState(() => _isEditing = !_isEditing);
    if (_isEditing) {
      _focusNode.requestFocus();
    } else {
      _saveChanges();
    }
  }

  void _saveChanges() {
    setState(() => _isEditing = false);
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Metin genişliğini hesaplayan yardımcı fonksiyon
  double _calculateTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width + 4; // Padding ekliyoruz
  }

  @override
  Widget build(BuildContext context) {
    final textWidth = _calculateTextWidth(
      _controller.text,
      context.general.textTheme.titleMedium!
          .copyWith(fontWeight: FontWeight.w600),
    );

    return GestureDetector(
      onTap: _toggleEditing,
      child: IntrinsicWidth(
        // Genişliği içeriğe göre ayarlar
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: textWidth,
              child: TextField(
                maxLength: 20,
                controller: _controller,
                focusNode: _focusNode,
                readOnly: !_isEditing,
                style: context.general.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
                decoration: _decoration(),
                onSubmitted: (text) => _saveChanges(),
                onChanged: widget.onSubmitted,
              ),
            ),
            context.sized.emptySizedWidthBoxLow,
            Icon(
              _isEditing ? Icons.check : Icons.edit,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration() {
    return const InputDecoration(
      border: InputBorder.none,
      isCollapsed: true,
      counter: SizedBox.shrink(),
    );
  }
}
