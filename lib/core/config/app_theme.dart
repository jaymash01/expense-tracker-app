import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/config/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/config/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.light.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.light.primary!,
      secondary: AppColors.light.secondary!,
      surface: Colors.white,
      surfaceTint: Colors.transparent,
      error: AppColors.light.danger!,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
      outline: Colors.black12,
    ),
    fontFamily: AppTextStyles.fontFamily,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.black54),
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall.copyWith(color: Colors.black54),
    ),
    iconTheme: IconThemeData(color: Colors.black54),
    appBarTheme: AppBarTheme(
      elevation: AppDimensions.elevationNone,
      backgroundColor: AppColors.light.background,
      foregroundColor: Colors.black,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        fontSize: 18,
        color: Colors.black,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        color: AppColors.light.primary,
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      dividerHeight: 0,
      dividerColor: Colors.black12,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: AppDimensions.elevationNone,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.light.primary,
      unselectedItemColor: Colors.white70,
      selectedItemColor: AppColors.light.secondary,
      selectedLabelStyle: AppTextStyles.bodySmall,
      unselectedLabelStyle: AppTextStyles.bodySmall,
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: AppDimensions.elevationNone,
      height: 76,
      backgroundColor: AppColors.light.primary,
      indicatorColor: AppColors.light.secondary!.withAlpha(45),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: AppColors.light.secondary,
            size: AppDimensions.iconSizeS,
          );
        }

        return IconThemeData(
          color: Colors.white70,
          size: AppDimensions.iconSizeS,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: AppColors.light.secondary,
            fontSize: AppTextStyles.bodySmall.fontSize,
          );
        }

        return TextStyle(
          color: Colors.white70,
          fontSize: AppTextStyles.bodySmall.fontSize,
        );
      }),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(AppDimensions.buttonHeightM),
        elevation: AppDimensions.elevationNone,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
        ),
        backgroundColor: AppColors.light.primary,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(AppDimensions.buttonHeightM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide(width: 1.0, color: AppColors.light.secondary!),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.light.primary!.withAlpha(38),
      contentPadding: AppDimensions.formFieldPadding,
      prefixIconColor: Colors.black54,
      suffixIconColor: Colors.black54,
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.black54),
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      shadowColor: Colors.black12,
      elevation: AppDimensions.elevationL,
      margin: EdgeInsets.zero,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.light.primary!;
        }

        return Colors.black26;
      }),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.light.secondary!.withAlpha(45),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.black54,
      titleTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.black),
      subtitleTextStyle: AppTextStyles.bodySmall.copyWith(
        color: Colors.black54,
      ),
      minTileHeight: 40.0,
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      backgroundColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.black12, thickness: 1.0),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.light.primary,
      linearTrackColor: AppColors.light.primary!.withAlpha(38),
    ),
    extensions: <ThemeExtension<dynamic>>[AppColors.light],
  );

  static final dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.dark.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.dark.primary!,
      secondary: AppColors.dark.secondary!,
      surface: AppColors.dark.background!,
      surfaceTint: Colors.transparent,
      error: AppColors.dark.danger!,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
      outline: Colors.white12,
    ),
    fontFamily: AppTextStyles.fontFamily,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall.copyWith(color: Colors.white70),
    ),
    iconTheme: IconThemeData(color: Colors.white70),
    appBarTheme: AppBarTheme(
      elevation: AppDimensions.elevationNone,
      backgroundColor: AppColors.dark.background,
      foregroundColor: Colors.white,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        fontSize: 18,
        color: Colors.white,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        color: AppColors.dark.primary,
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      dividerHeight: 0,
      dividerColor: Colors.white12,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: AppDimensions.elevationNone,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.dark.background,
      unselectedItemColor: Colors.white,
      selectedItemColor: AppColors.light.secondary,
      selectedLabelStyle: AppTextStyles.bodySmall,
      unselectedLabelStyle: AppTextStyles.bodySmall,
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: AppDimensions.elevationL,
      height: 76,
      backgroundColor: AppColors.dark.background,
      indicatorColor: AppColors.dark.secondary!.withAlpha(45),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: AppColors.dark.secondary,
            size: AppDimensions.iconSizeS,
          );
        }

        return IconThemeData(
          color: Colors.white,
          size: AppDimensions.iconSizeS,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: AppColors.dark.secondary,
            fontSize: AppTextStyles.bodySmall.fontSize,
          );
        }

        return TextStyle(
          color: Colors.white,
          fontSize: AppTextStyles.bodySmall.fontSize,
        );
      }),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(AppDimensions.buttonHeightM),
        elevation: AppDimensions.elevationNone,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
        ),
        backgroundColor: AppColors.dark.primary,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(AppDimensions.buttonHeightM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide(width: 1.0, color: Colors.white12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide(width: 1.0, color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide(width: 1.0, color: AppColors.light.secondary!),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.dark.primary!.withAlpha(12),
      contentPadding: AppDimensions.formFieldPadding,
      prefixIconColor: Colors.white70,
      suffixIconColor: Colors.white70,
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      shadowColor: Colors.black87,
      elevation: AppDimensions.elevationL,
      margin: EdgeInsets.zero,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.dark.primary!;
        }

        return Colors.white38;
      }),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.dark.secondary!.withAlpha(45),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white70,
      titleTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      subtitleTextStyle: AppTextStyles.bodySmall.copyWith(
        color: Colors.white70,
      ),
      minTileHeight: 40.0,
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      backgroundColor: AppColors.dark.background,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.white12, thickness: 1.0),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.dark.primary,
      linearTrackColor: AppColors.dark.primary!.withAlpha(38),
    ),
    extensions: <ThemeExtension<dynamic>>[AppColors.dark],
  );
}
