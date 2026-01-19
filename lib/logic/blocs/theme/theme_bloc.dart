import 'package:expense_tracker/core/config/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/config/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
    : super(ThemeState(themeData: AppTheme.light, isDarkMode: false)) {
    on<ThemeCheckRequested>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final themeMode = prefs.getString(Preferences.themeMode) ?? 'Light';

      if (themeMode == 'Dark') {
        add(DarkThemeSelected());
      } else {
        add(LightThemeSelected());
      }
    });

    on<LightThemeSelected>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(Preferences.themeMode, 'Light');
      emit(ThemeState(themeData: AppTheme.light, isDarkMode: false));
    });

    on<DarkThemeSelected>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(Preferences.themeMode, 'Dark');

      emit(ThemeState(themeData: AppTheme.dark, isDarkMode: true));
    });
  }
}
