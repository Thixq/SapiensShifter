import 'package:flutter/services.dart';
import 'package:sapiensshifter/product/utils/extensions/double_extension.dart';

final class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter(this.divisor);

  final int divisor;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    final intValue = int.tryParse(newValue.text.replaceAll('.', ''));

    final formattedValue = (intValue ?? 0) / divisor;

    final newText = formattedValue.sapiDoubleExt.priceFraction;
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText!.length),
    );
  }
}
