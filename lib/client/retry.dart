import 'package:antenna_app/debug/report.dart';
import "package:http/http.dart";

Future<Response> retry(Future<Response> Function() fn, {int count = 5}) async {
  final response = await fn();

  if (count == 0) {
    return response;
  }

  if (response.statusCode == 500) {
    report("Response status code is 500. Retry once ...");

    await Future.delayed(const Duration(milliseconds: 5000));

    return retry(fn, count: 0);
  }

  if (response.statusCode == 429 ||
      response.statusCode == 501 ||
      response.statusCode == 502 ||
      response.statusCode == 503) {
    report("Response status code is ${response.statusCode}. Retry ...");

    await Future.delayed(const Duration(milliseconds: 1000));

    return retry(fn, count: count - 1);
  }

  return response;
}
