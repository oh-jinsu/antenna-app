extension IterableExtension<T> on Iterable<T> {
  Iterable<T> sorted([int Function(T, T)? compare]) {
    final copy = toList();

    copy.sort(compare);

    return copy;
  }

  Future<Iterable<U>> parallel<U>(Future<U> Function(T) toElement) {
    return Future.wait(map(toElement));
  }
}
