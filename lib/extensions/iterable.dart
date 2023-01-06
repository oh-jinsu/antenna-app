extension IterableExtension<T> on Iterable<T> {
  Iterable<T> sort([int Function(T, T)? compare]) {
    final list = toList();

    list.sort(compare);

    return list;
  }
}
