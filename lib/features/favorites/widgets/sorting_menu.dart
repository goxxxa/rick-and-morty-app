import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';

class SortingMenu extends StatelessWidget {
  const SortingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortingTypes>(
      icon: const Icon(Icons.sort),
      onSelected: (option) {
        context.read<FavoritesBLoC>().add(FavoritesSorted(type: option));
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
