import 'dart:async';

import 'package:antenna/antenna.dart';
import 'package:antenna_app/events/auth_needed.dart';
import 'package:antenna_app/repositories/auth.dart';

Completer<String>? completer;

Timer? completerTimer;

Future<String> ensureRefreshTokenFound({
  Duration duration = const Duration(seconds: 1),
}) async {
  final refreshToken = await findRefreshToken();

  if (refreshToken != null) {
    return refreshToken;
  }

  dispatch(const AuthNeeded());

  if (completerTimer != null) {
    completerTimer!.cancel();
  }

  final result = Completer<String>();

  if (completer != null) {
    completer!.completeError(Exception("Canceled by other request"));

    completer = result;
  }

  completerTimer = Timer.periodic(duration, (timer) async {
    final refreshToken = await findRefreshToken();

    if (refreshToken == null) {
      return;
    }

    completer?.complete(refreshToken);

    completerTimer?.cancel();
  });

  return result.future;
}
