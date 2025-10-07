import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/theme/cubit/theme_cubit.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_event.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_state.dart';
import 'package:rick_and_morty_app/features/characters/widgets/list_title.dart';

/// {@template characters_screen}
/// CharactersScreen widget.
/// {@endtemplate}
class CharactersPage extends StatefulWidget {
  /// {@macro characters_screen}
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

/// State for widget CharactersScreen.
class _CharactersPageState extends State<CharactersPage> {
  ScrollController? _scrollController;
  int count = 20;

  bool show = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollControllerListener);
    super.initState();
    // Initial state initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AnimatedSlide(
        offset: show ? Offset.zero : Offset(0, 2),
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: show ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: () {
              _scrollController?.animateTo(
                0,
                duration: const Duration(seconds: 2),
                curve: Curves.linearToEaseOut,
              );
            },
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CharacterBLoC, CharacterPageState>(
          bloc: context.read<CharacterBLoC>(),
          builder: (context, state) {
            return state.when(
              processing: () =>
                  const Center(child: CircularProgressIndicator()),
              idle: () => const Center(child: CircularProgressIndicator()),
              loaded: (characters, ids) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor: Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'The Rick and Morty App',
                            style: TextStyle(color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                            icon: const Icon(Icons.sunny, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      sliver: SliverList.separated(
                        itemCount: characters.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          var show = (ids.contains(characters[index].id));
                          return MyListTitle(
                            index: index,
                            data: characters,
                            bloc: context.read<CharacterBLoC>(),
                            show: show,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _scrollControllerListener() {
    if (_scrollController?.position.userScrollDirection ==
            ScrollDirection.reverse ||
        _scrollController?.position.pixels ==
            _scrollController?.position.minScrollExtent) {
      setState(() {
        show = false;
      });
    } else if (_scrollController?.position.userScrollDirection ==
        ScrollDirection.idle) {
      setState(() {
        show = true;
      });
    } else {
      setState(() {
        show = true;
      });
    }
    if (_scrollController!.position.pixels >=
        (_scrollController!.position.maxScrollExtent - 100.0)) {
      count += 10;
      final ids = List<int>.generate(count, (int index) => (index + 1));
      context.read<CharacterBLoC>().add(ChractersGetData(ids: ids));
    }
  }
}
