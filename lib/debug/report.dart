import 'package:flutter/foundation.dart';

void report(Object object) {
  if (kDebugMode) {
    print(object);
  }
}
