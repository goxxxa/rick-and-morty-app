import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/core/database/database.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';
import 'package:talker/talker.dart';

/// {@template favorites_list_title}
/// FavoritesListTitle widget.
/// {@endtemplate}
class FavoritesListTitle extends StatelessWidget {
  final List<Character> data;
  final int index;

  /// {@macro favorites_list_title}
  const FavoritesListTitle({
    super.key,
    required this.data,
    required this.index,
    // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 225, 225, 225),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(data[index].image),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index].name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('${data[index].status} - ${data[index].species}'),
                Text('Last known location:'),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          const SizedBox(height: 3),
                          Text(
                            data[index].type,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 138, 138, 138),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          RepaintBoundary(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8),
              child: IconButton(
                onPressed: () {
                  GetIt.instance<Talker>().info('DELETE!');
                  context.read<FavoritesBLoC>().add(
                    DeleteCharacterFromFavorites(id: data[index].id),
                  );
                },
                icon: Icon(Icons.delete),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
