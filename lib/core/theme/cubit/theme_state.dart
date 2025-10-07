part of 'theme_cubit.dart';

class ThemeState {
  final ThemeData theme;
  final bool isDarkMode;

  const ThemeState._(this.theme, this.isDarkMode);

  ThemeState.light() : this._(RickAndMortyAppTheme.light, false);
  ThemeState.dark() : this._(RickAndMortyAppTheme.dark, true);
}
