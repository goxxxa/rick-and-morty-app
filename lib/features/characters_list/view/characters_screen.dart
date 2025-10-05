import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_app/features/characters_list/bloc/characters_list_bloc.dart';
import 'package:rick_and_morty_app/features/characters_list/bloc/characters_list_event.dart';
import 'package:rick_and_morty_app/features/characters_list/bloc/characters_list_state.dart';
import 'package:rick_and_morty_app/features/characters_list/widgets/list_title.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';

/// {@template characters_screen}
/// CharactersScreen widget.
/// {@endtemplate}
class CharactersScreen extends StatefulWidget {
  /// {@macro characters_screen}
  const CharactersScreen({
    super.key,
    required this.title, // ignore: unused_element
  });

  final String title;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _CharactersScreenState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_CharactersScreenState>();

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

/// State for widget CharactersScreen.
class _CharactersScreenState extends State<CharactersScreen> {
  CharacterBLoC? _bloc;
  /* #region Lifecycle */
  @override
  void initState() {
    _bloc = CharacterBLoC()..add(ChractersGetData());
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant CharactersScreen oldWidget) {
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
    final repo = CharacterRepository();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text(widget.title)),
      body: Center(
        child: BlocBuilder<CharacterBLoC, CharacterPageState>(
          bloc: _bloc,
          builder: (context, state) {
            return state.when(
              processing: () =>
                  Center(child: const CircularProgressIndicator()),
              idle: () => Center(child: const CircularProgressIndicator()),
              loaded: (characters) {
                return ListView.separated(
                  itemCount: characters.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context_, index) {
                    return MyListTitle(index: index, data: characters);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
