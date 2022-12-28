import 'package:intl/intl.dart';

final numberFormat = NumberFormat('###,###,###,###');

extension NumberExtension on num {
  num get negative {
    return -1 * this;
  }

  String get won {
    return "${numberFormat.format(this)}원";
  }
}
