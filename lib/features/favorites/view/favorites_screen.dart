import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// {@template favorites_screen}
/// FavoritesScreen widget.
/// {@endtemplate}
class FavoritesScreen extends StatefulWidget {
  /// {@macro favorites_screen}
  const FavoritesScreen({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _FavoritesScreenState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_FavoritesScreenState>();

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

/// State for widget FavoritesScreen.
class _FavoritesScreenState extends State<FavoritesScreen> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant FavoritesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => const Placeholder();
}
