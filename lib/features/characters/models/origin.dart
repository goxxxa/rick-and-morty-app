import 'package:equatable/equatable.dart';

class Origin extends Equatable {
  final String name;
  final String url;

  const Origin({required this.name, required this.url});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(name: json["name"], url: json["url"]);
  }

  @override
  List<Object?> get props => [name, url];

  @override
  String toString() => '''Origin { name: $name, url: $url}''';
}

class Location extends Equatable {
  final String name;
  final String url;

  const Location({required this.name, required this.url});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json["name"], url: json["url"]);
  }

  @override
  List<Object?> get props => [name, url];

  @override
  String toString() => '''Location { id: $name, url^ $url} ''';
}
