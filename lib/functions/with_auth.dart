import 'dart:async';

import 'package:antenna_app/client/endpoint.dart';
import 'package:antenna_app/client/http.dart';
import 'package:antenna_app/client/response.dart';
import 'package:antenna_app/debug/report.dart';
import 'package:antenna_app/functions/ensure_refresh_token_found.dart';
import 'package:antenna_app/repositories/auth.dart';

Future<Response> withAuth(
  Future<Response> Function(String accessToken) fn,
) async {
  final accessToken = findAccessToken();

  if (accessToken != null) {
    final response = await fn(accessToken);

    if (response is SuccessResponse) {
      return response;
    }

    if (response is FailureResponse) {
      if (response.statusCode == 401) {
        deleteAccessToken();
      } else {
        return response;
      }
    }
  }

  report("Try to refresh ...");

  final refreshToken = await ensureRefreshTokenFound();

  final response = await post(
    endpoint("auth/refresh"),
    body: {
      "refreshToken": refreshToken,
    },
  );

  if (response is FailureResponse) {
    return withAuth(fn);
  }

  if (response is SuccessResponse) {
    final accessToken = response.body["accessToken"];

    saveAccessToken(accessToken);

    return fn(accessToken);
  }

  throw Error();
}
