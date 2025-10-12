import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/favorites/favorites.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesSubscriptionRequested extends FavoritesEvent {
  const FavoritesSubscriptionRequested();
}

class FavoriteDeleted extends FavoritesEvent {
  final int id;

  const FavoriteDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class FavoritesSorted extends FavoritesEvent {
  final SortingTypes type;

  const FavoritesSorted({required this.type});

  @override
  List<Object?> get props => [type];
}
