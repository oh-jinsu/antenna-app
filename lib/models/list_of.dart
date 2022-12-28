import 'package:antenna_app/models/option.dart';

class ListOf<T> {
  final String? next;
  final List<T> items;

  const ListOf({
    required this.next,
    required this.items,
  });

  factory ListOf.fromJson(dynamic json, T Function(dynamic json) mapper) {
    return ListOf(
      next: json["next"],
      items: (json["items"] as List).map(mapper).toList(),
    );
  }

  ListOf<T> copy({
    Option<String>? next,
    List<T>? items,
  }) {
    return ListOf(
      next: next != null ? next.value : this.next,
      items: items ?? this.items,
    );
  }
}
