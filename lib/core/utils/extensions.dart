import 'package:flutter/material.dart';
import 'package:expense_tracker/core/config/app_colors.dart';

extension StringExtensions on String {
  String capitalize([String separator = ' ']) {
    List<String> parts = split(separator)
        .map((element) => '${element[0].toUpperCase()}${element.substring(1)}')
        .toList();
    return parts.join(' ');
  }

  String replaceAt(int index, String newValue) {
    return substring(0, index) + newValue + substring(index + 1, length);
  }
}

extension AppThemeContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
