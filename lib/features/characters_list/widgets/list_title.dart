import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

/// {@template list_title}
/// ListTitle widget.
/// {@endtemplate}
class MyListTitle extends StatelessWidget {
  final int index;
  final List<CharacterModel> data;

  /// {@macro list_title}
  const MyListTitle({
    super.key,
    required this.index,
    required this.data, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: const Color.fromARGB(255, 60, 62, 68),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(data[index].image),
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
                Text(data[index].location.name),
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
          Icon(Icons.star_border_outlined),
        ],
      ),
    );
  }
}
