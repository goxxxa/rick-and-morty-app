part of 'home_cubit.dart';

enum HomeTab { characters, favorites }

final class HomeState extends Equatable {
  const HomeState({this.tab = HomeTab.characters});

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
