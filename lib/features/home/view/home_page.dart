import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/favorites/favorites.dart';
import 'package:rick_and_morty_app/features/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeCubit(), child: const HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.select((HomeCubit cubit) => cubit.state.tab.index),
        children: const [CharactersPage(), FavoritesPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.select(
          (HomeCubit cubit) => cubit.state.tab.index,
        ),
        onTap: (index) {
          final tab = HomeTab.values[index];
          context.read<HomeCubit>().setTab(tab);
        },
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Theme.of(context).dividerColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Characters'),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_rounded),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
