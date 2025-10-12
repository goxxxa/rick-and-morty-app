import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rick_and_morty_app/ui/theme/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: RickAndMortyAppTheme.light));

  void toggleTheme() {
    if (state.isDarkMode) {
      emit(ThemeState.light());
    } else {
      emit(ThemeState.dark());
    }
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final isDark = json['isDark'] as bool? ?? false;
    return ThemeState(
      theme: isDark ? RickAndMortyAppTheme.dark : RickAndMortyAppTheme.light,
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {'isDark': state.isDarkMode};
  }
}
