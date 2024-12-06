import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SapiTextField extends StatefulWidget {
  const SapiTextField({
    this.controller,
    this.autofillHints,
    this.validator,
    this.hintText,
    this.isPassword = false,
    super.key,
  });
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
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
      decoration: _sapiDecoration(
        context,
        hintText: widget.hintText,
      ),
      autofillHints: widget.autofillHints,
      controller: widget.controller,
    );
  }

  InputDecoration _sapiDecoration(BuildContext context, {String? hintText}) {
    return InputDecoration(
      suffixIcon: _suffixIconVal,
      hintText: hintText,
      border:
          OutlineInputBorder(borderRadius: context.border.normalBorderRadius),
    );
  }

  bool get _obscureTextVal => widget.isPassword ? _visibilityChange : false;

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
