extension DateTimeExtension on DateTime {
  int get hour12 {
    return hour > 12 ? hour - 12 : hour;
  }

  String get meridium {
    return hour >= 12 ? "오후" : "오전";
  }

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
