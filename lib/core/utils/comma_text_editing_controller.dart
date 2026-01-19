import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommaTextEditingController extends TextEditingController {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  set text(String newText) {
    // 1. Strip any existing commas first
    String rawText = newText.replaceAll(',', '');

    // 2. Format the raw number
    if (rawText.isNotEmpty && double.tryParse(rawText) != null) {
      String formatted = _formatter.format(int.parse(rawText));

      // 3. Set the value using the super class
      super.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else {
      super.text = newText;
    }
  }

  // Helper to get the numeric value easily
  num get numValue => num.tryParse(text.replaceAll(',', '')) ?? 0;
}
