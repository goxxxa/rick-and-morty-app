import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_state.dart';
import 'package:rick_and_morty_app/features/favorites/widgets/favorites_list_title.dart';
import 'package:rick_and_morty_app/features/favorites/widgets/sorting_menu.dart';

/// {@template favorites_screen}
/// FavoritesScreen widget.
/// {@endtemplate}
class FavoritesPage extends StatefulWidget {
  /// {@macro favorites_screen}
  const FavoritesPage({
    super.key, // ignore: unused_element
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

/// State for widget FavoritesScreen.
class _FavoritesPageState extends State<FavoritesPage> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant FavoritesPage oldWidget) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [const SortingMenu()],
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: BlocBuilder<FavoritesBLoC, FavoritesPageState>(
            bloc: context.read<FavoritesBLoC>(),
            builder: (context, state) {
              return state.when(
                processing: () => Center(child: CircularProgressIndicator()),
                idle: () => Center(child: CircularProgressIndicator()),
                loaded: (characters) {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return FavoritesListTitle(data: characters, index: index);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 12),
                    itemCount: characters.length,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
