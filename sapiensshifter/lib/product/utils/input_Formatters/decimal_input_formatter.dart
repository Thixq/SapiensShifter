import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter({this.decimalRange = 2})
      : assert(
          decimalRange >= 0,
          'The number of decimal places cannot be negative.',
        );

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final onlyDigits = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    if (onlyDigits.isEmpty) {
      return oldValue;
    }

    String formatted;
    if (onlyDigits.length <= decimalRange) {
      final padded = onlyDigits.padLeft(decimalRange, '0');
      formatted = '0.$padded';
    } else {
      final split = onlyDigits.length - decimalRange;
      var integerPart =
          onlyDigits.substring(0, split).replaceFirst(RegExp('^0+'), '');
      if (integerPart.isEmpty) integerPart = '0';
      final decimalPart = onlyDigits.substring(split);
      formatted = '$integerPart.$decimalPart';
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
