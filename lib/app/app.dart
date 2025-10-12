import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/home/home.dart';
import 'package:rick_and_morty_app/repositories/characters/characters_repository.dart';
import 'package:rick_and_morty_app/ui/theme/cubit/theme_cubit.dart';

class App extends StatelessWidget {
  const App({required this.createCharactersRepository, super.key});

  final CharactersRepository Function() createCharactersRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CharactersRepository>(
      create: (_) => createCharactersRepository(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
