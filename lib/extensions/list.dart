import 'package:flutter/material.dart';

extension ListExtension<T> on List<T> {
  List<Widget> view(
    Widget Function(T item) builder, {
    Widget? divider,
  }) {
    final result = <Widget>[];

    for (int i = 0; i < length * 2 - 1; i++) {
      if (i % 2 == 0) {
        result.add(builder(this[i ~/ 2]));
      } else if (divider != null) {
        result.add(divider);
      }
    }

    return result;
  }
}
