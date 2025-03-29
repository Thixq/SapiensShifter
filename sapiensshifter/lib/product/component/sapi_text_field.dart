import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

final class SapiTextField extends StatefulWidget {
  const SapiTextField({
    this.controller,
    this.autofillHints,
    this.keyboardType,
    this.validator,
    this.hintText,
    this.isPassword = false,
    this.textInputAction = TextInputAction.done,
    super.key,
  });
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final TextInputAction textInputAction;
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
      textInputAction: widget.textInputAction,
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
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.sized.normalValue),
      ),
    );
  }

  bool get _obscureTextVal => widget.isPassword && _visibilityChange;

  Widget? get _suffixIconVal => widget.isPassword
      ? Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            onPressed: _changeSuffixIcon,
            icon: Icon(
              _visibilityChange
                  ? _visibilityOffSuffixIcon
                  : _visibilitySuffixIcon,
            ),
          ),
        )
      : null;
}
