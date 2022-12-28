extension DateTimeExtension on DateTime {
  DateTime get midnight {
    return subtract(Duration(
      hours: hour,
      minutes: minute,
      seconds: second,
      milliseconds: millisecond,
      microseconds: microsecond,
    ));
  }
}
