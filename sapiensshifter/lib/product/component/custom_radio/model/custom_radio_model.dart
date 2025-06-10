import 'package:flutter/material.dart';

class CustomRadioModel<T> {
  CustomRadioModel({required this.widget, required this.value});

  final Widget widget;
  final T value;
  CustomRadioModel<T> copyWith({
    Widget? widget,
    T? value,
  }) {
    return CustomRadioModel<T>(
      widget: widget ?? this.widget,
      value: value ?? this.value,
    );
  }
}
