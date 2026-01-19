import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 1. Strip existing commas to get the raw number
    String newText = newValue.text.replaceAll(',', '');

    // 2. Format the number with commas
    final formatter = NumberFormat('#,###');
    String formattedText = formatter.format(int.parse(newText));

    // 3. Return the new value with the correct cursor position
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
