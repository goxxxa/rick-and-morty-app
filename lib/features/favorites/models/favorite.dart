import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final int id;

  const Favorite({required this.id});

  @override
  List<Object?> get props => [id];
}
