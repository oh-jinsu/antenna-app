import 'package:flutter/material.dart';

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> sorted([int Function(T, T)? compare]) {
    final copy = toList();

    copy.sort(compare);

    return copy;
  }

  Future<Iterable<U>> parallel<U>(Future<U> Function(T) toElement) {
    return Future.wait(map(toElement));
  }

  List<Widget> view(
    Widget Function(T item) builder, {
    Widget? divider,
  }) {
    final result = <Widget>[];

    for (int i = 0; i < length * 2 - 1; i++) {
      if (i % 2 == 0) {
        result.add(builder(toList()[i ~/ 2]));
      } else if (divider != null) {
        result.add(divider);
      }
    }

    return result;
  }
}
