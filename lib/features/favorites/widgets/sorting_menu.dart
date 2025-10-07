import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';

/// {@template sorting_menu}
/// SortingMenu widget.
/// {@endtemplate}
class SortingMenu extends StatelessWidget {
  /// {@macro sorting_menu}
  const SortingMenu({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortingTypes>(
      initialValue: SortingTypes.byNameAsc,
      icon: const Icon(Icons.sort),
      onSelected: (option) {
        context.read<FavoritesBLoC>().add(SortFavorites(type: option));
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: SortingTypes.byNameAsc,
          child: Text('Sort by Name ↑'),
        ),
        const PopupMenuItem(
          value: SortingTypes.byNameDesc,
          child: Text('Sort by Name ↓'),
        ),
        const PopupMenuItem(
          value: SortingTypes.byStatusAsc,
          child: Text('Sort by Status ↑'),
        ),
        const PopupMenuItem(
          value: SortingTypes.byStatusDesc,
          child: Text('Sort by Status ↓'),
        ),
      ],
    );
  }
}

enum SortingTypes {
  byNameAsc,
  byNameDesc,
  byStatusAsc,
  byStatusDesc,
  bySpeciesAsc,
  bySpeciesDesc,
}
