import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_event.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

/// {@template list_title}
/// ListTitle widget.
/// {@endtemplate}
class MyListTitle extends StatelessWidget {
  final int index;
  final List<CharacterModel> data;
  final CharacterBLoC bloc;

  /// {@macro list_title}
  const MyListTitle({
    super.key,
    required this.index,
    required this.data,
    required this.bloc, // ignore: unused_element
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
            child: CachedNetworkImage(
              imageUrl: data[index].image,
              // fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
            ),
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
                Text(data[index].location!.name),
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
                  bloc.add(AddCharacterToFavorites(id: data[index].id));
                },
                icon: Icon(Icons.star),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
