import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/core/config/app_colors.dart';

class AppSystemUiOverlayStyle {
  static final light = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.light.background!,
    systemNavigationBarDividerColor: AppColors.light.background!,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarContrastEnforced: false,
  );

  static final dark = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.dark.background,
    systemNavigationBarDividerColor: AppColors.dark.background!,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: false,
  );
}
