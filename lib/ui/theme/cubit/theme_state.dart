part of 'theme_cubit.dart';

class ThemeState {
  final ThemeData theme;
  const ThemeState({required this.theme});

  bool get isDarkMode => theme.brightness == Brightness.dark;

  factory ThemeState.light() => ThemeState(theme: RickAndMortyAppTheme.light);
  factory ThemeState.dark() => ThemeState(theme: RickAndMortyAppTheme.dark);
}
