import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_state.dart';
import 'package:rick_and_morty_app/features/favorites/widgets/favorites_list_title.dart';

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
  FavoritesBLoC? _bloc;
  /* #region Lifecycle */
  @override
  void initState() {
    _bloc = FavoritesBLoC()..add(GetFavoritesCharacters());
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant FavoritesPage oldWidget) {
    _bloc ??= FavoritesBLoC()..add(GetFavoritesCharacters());
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    _bloc ??= FavoritesBLoC()..add(GetFavoritesCharacters());
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Favorites'),
            IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: BlocBuilder<FavoritesBLoC, FavoritesPageState>(
            bloc: _bloc,
            builder: (context, state) {
              return state.when(
                processing: () => Center(child: CircularProgressIndicator()),
                idle: () => Center(child: CircularProgressIndicator()),
                loaded: (characters) {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return FavoritesListTitle(
                        data: characters,
                        index: index,
                        bloc: _bloc!,
                      );
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
