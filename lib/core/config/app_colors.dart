import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? primary;
  final Color? secondary;
  final Color? background;
  final Color? info;
  final Color? success;
  final Color? warning;
  final Color? danger;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.info,
    required this.success,
    required this.warning,
    required this.danger,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? info,
    Color? success,
    Color? warning,
    Color? danger,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      info: info ?? this.info,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      background: Color.lerp(background, other.background, t),
      info: Color.lerp(info, other.info, t),
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  static const light = AppColors(
    primary: Color(0xFF33506E),
    secondary: Color(0xFFF7941D),
    background: Color(0xFFF1F3F4),
    info: Color(0xFF2196F3),
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFC107),
    danger: Color(0xFFF44336),
  );

  static const dark = AppColors(
    primary: Color(0xFF336EAC),
    secondary: Color(0xFFD67F15),
    background: Color(0xFF1B1D28),
    info: Color(0xFF64B5F6),
    success: Color(0xFF81C784),
    warning: Color(0xFFFFD54F),
    danger: Color(0xFFE57373),
  );
}
