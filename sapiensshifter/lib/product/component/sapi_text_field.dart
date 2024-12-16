import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class SapiTextField extends StatefulWidget {
  const SapiTextField({
    this.controller,
    this.autofillHints,
    this.keyboardType,
    this.validator,
    this.hintText,
    this.isPassword = false,
    super.key,
  });
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  @override
  State<SapiTextField> createState() => _SapiTextFieldState();
}

class _SapiTextFieldState extends State<SapiTextField> {
  final IconData _visibilitySuffixIcon = Icons.visibility;
  final IconData _visibilityOffSuffixIcon = Icons.visibility_off;
  bool _visibilityChange = true;

  void _changeSuffixIcon() {
    setState(() {
      _visibilityChange = !_visibilityChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureTextVal,
      validator: widget.validator,
      decoration: _sapiDecoration(context, hintText: widget.hintText),
      autofillHints: widget.autofillHints,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
    );
  }

  InputDecoration _sapiDecoration(BuildContext context, {String? hintText}) {
    return InputDecoration(
      contentPadding: context.padding.normal,
      suffixIcon: _suffixIconVal,
      hintText: hintText,
      border:
          OutlineInputBorder(borderRadius: context.border.normalBorderRadius),
    );
  }

  bool get _obscureTextVal => widget.isPassword && _visibilityChange;

  IconButton? get _suffixIconVal => widget.isPassword
      ? IconButton(
          onPressed: _changeSuffixIcon,
          icon: Icon(
            _visibilityChange
                ? _visibilityOffSuffixIcon
                : _visibilitySuffixIcon,
          ),
        )
      : null;
}
