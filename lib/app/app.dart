import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/app/cubit/navigation_cubit.dart';
import 'package:rick_and_morty_app/core/theme/cubit/theme_cubit.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_event.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty_app/features/favorites/favorites.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'The Rick and Morty App',
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            home: const MainNavigation(),
          );
        },
      ),
    );
  }
}

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CharacterBLoC()..add(ChractersGetData())),
        BlocProvider(
          create: (_) => FavoritesBLoC()..add(GetFavoritesCharacters()),
        ),
      ],
      child: BlocListener<NavigationCubit, AppTab>(
        listener: (context, tab) {
          if (tab == AppTab.favorites) {
            context.read<FavoritesBLoC>().add(GetFavoritesCharacters());
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: context.watch<NavigationCubit>().state.index,
            children: const [CharactersPage(), FavoritesPage()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.watch<NavigationCubit>().state.index,
            onTap: (index) {
              context.read<NavigationCubit>().updateTab(AppTab.values[index]);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
