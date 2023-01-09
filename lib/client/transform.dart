import 'dart:convert';

import 'package:antenna_app/client/response.dart';
import 'package:antenna_app/debug/report.dart';
import 'package:http/http.dart' as http;

Response transform(String info, http.Response response) {
  final statusCode = response.statusCode;

  final responseBody = response.body.isNotEmpty
      ? jsonDecode(utf8.decode(response.bodyBytes))
      : null;

  report(
    "Response $statusCode $info\nResponseBody ${const JsonEncoder.withIndent(" ").convert(responseBody)}",
  );

  if (statusCode < 400) {
    return SuccessResponse(
      body: responseBody,
    );
  } else {
    return FailureResponse(
      statusCode: statusCode,
      message: responseBody["message"],
    );
  }
}
