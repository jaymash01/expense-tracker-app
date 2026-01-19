import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeCheckRequested extends ThemeEvent {}

class LightThemeSelected extends ThemeEvent {}

class DarkThemeSelected extends ThemeEvent {}
