import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/repositories/characters/characters_repository.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_event.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_state.dart';
import 'package:rick_and_morty_app/ui/theme/cubit/theme_cubit.dart';
import 'package:rick_and_morty_app/ui/widgets/widgets.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CharactersBloc(repository: context.read<CharactersRepository>())
            ..add(LoadInitialCharacters()),
      child: CharactersView(),
    );
  }
}

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  late final ScrollController _scrollController;
  final _showScrollUp = ValueNotifier<bool>(false);
  int count = 20;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _showScrollUp,
        builder: (context, show, child) {
          return AnimatedSlide(
            offset: show ? Offset.zero : Offset(0, 2),
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              opacity: show ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.linearToEaseOut,
                  );
                },
                child: const Icon(Icons.arrow_upward),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rick and Morty App'),
            IconButton(
              onPressed: context.read<ThemeCubit>().toggleTheme,
              icon: Icon(Icons.sunny),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              return state.when(
                processing: () =>
                    const Center(child: CircularProgressIndicator()),
                idle: () => const Center(child: CircularProgressIndicator()),
                loaded: (characters) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CharactersBloc>().add(
                        RefreshCharactersData(),
                      );
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: characters.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) => RepaintBoundary(
                        child: CharacterListCard(
                          key: ValueKey(characters[index].id),
                          character: characters[index],
                          icon: characters[index].isFavorite
                              ? Icon(Icons.star, color: Colors.yellow)
                              : Icon(Icons.star_border),
                          onPressed: () => context.read<CharactersBloc>().add(
                            AddCharacterToFavorites(
                              character: characters[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                error: () => Center(
                  child: Text(
                    'Упссс...\n Что-то пошло не так. Попробуйте обновить приложение.',
                  ),
                ),
                empty: () => const Center(child: Text('Тут пока пусто!')),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _showScrollUp.dispose();
    super.dispose();
  }

  void _onScroll() {
    _showScrollUp.value =
        _scrollController.position.pixels >
        (_scrollController.position.maxScrollExtent / 10);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        count += 10;
      });
      context.read<CharactersBloc>().add(LoadMoreCharacters(count: count));
    }
  }
}
