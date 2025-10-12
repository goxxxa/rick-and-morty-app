import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_state.dart';
import 'package:rick_and_morty_app/features/favorites/widgets/sorting_menu.dart';
import 'package:rick_and_morty_app/repositories/characters/characters_repository.dart';
import 'package:rick_and_morty_app/ui/widgets/widgets.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          FavoritesBLoC(repository: context.read<CharactersRepository>())
            ..add(FavoritesSubscriptionRequested()),
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late final ScrollController _scrollController;
  final _showScrollUp = ValueNotifier<bool>(false);

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
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
          children: const [Text('Favorites'), SortingMenu()],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: BlocBuilder<FavoritesBLoC, FavoritesPageState>(
            builder: (context, state) {
              return state.when(
                processing: () => Center(child: CircularProgressIndicator()),
                idle: () => Center(child: CircularProgressIndicator()),
                loaded: (characters) {
                  return ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return CharacterListCard(
                        character: characters[index],
                        onPressed: () => context.read<FavoritesBLoC>().add(
                          FavoriteDeleted(id: characters[index].id),
                        ),
                        icon: Icon(Icons.delete),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemCount: characters.length,
                  );
                },
                empty: () => Center(
                  child: Text(
                    'Пока ничего не добавлено!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                error: (String message) => Center(child: Text(message)),
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

    super.dispose();
  }

  void _onScroll() {
    _showScrollUp.value =
        _scrollController.position.pixels >
        (_scrollController.position.maxScrollExtent / 10);
  }
}
