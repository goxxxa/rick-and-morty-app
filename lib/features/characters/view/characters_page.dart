import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _scrollController?.addListener(() {
      if (_scrollController?.position.userScrollDirection ==
              ScrollDirection.reverse ||
          _scrollController?.position.pixels ==
              _scrollController?.position.minScrollExtent) {
        setState(() {
          show = false;
        });
      } else {
        setState(() {
          show = true;
        });
      }
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        count += 10;
        final ids = List<int>.generate(
          10,
          (int index) => (count - 10 + index + 1),
        );
        context.read<CharacterBLoC>().add(ChractersGetData(ids: ids));
      }
    });
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant CharactersPage oldWidget) {
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
    _scrollController?.dispose();
    super.dispose();
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
              loaded: (characters) {
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
                            onPressed: null,
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
                          return MyListTitle(
                            index: index,
                            data: characters,
                            bloc: context.read<CharacterBLoC>(),
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
}
