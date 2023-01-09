import 'dart:convert';
import 'dart:io';

import 'package:antenna_app/client/response.dart';
import 'package:antenna_app/client/retry.dart';
import 'package:antenna_app/client/to_body.dart';
import 'package:antenna_app/client/transform.dart';
import 'package:antenna_app/debug/report.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as parser;

Future<Response> get<T>(
  String uri, {
  Map<String, String>? headers,
}) async {
  final info = "(GET) $uri";

  report("Request $info\nRequestHeader $headers");

  final response = await retry(
    () => http.get(
      Uri.parse(uri),
      headers: headers,
    ),
  );

  return transform(info, response);
}

Future<Response> post<T>(
  String uri, {
  Map<String, String>? headers,
  required dynamic body,
}) async {
  final info = "(POST) $uri";

  report(
    "Request $info\nRequestHeader $headers\nRequestBody ${const JsonEncoder.withIndent(" ").convert(body)}",
  );

  final response = await retry(
    () => http.post(
      Uri.parse(uri),
      headers: headers,
      body: toBody(body),
    ),
  );

  return transform(info, response);
}

Future<Response> put<T>(
  String uri, {
  Map<String, String>? headers,
  required dynamic body,
}) async {
  final info = "(PUT) $uri";

  report(
    "Request $info\nRequestHeader $headers\nRequestBody ${const JsonEncoder.withIndent(" ").convert(body)}",
  );

  final response = await retry(
    () => http.put(
      Uri.parse(uri),
      headers: headers,
      body: toBody(body),
    ),
  );

  return transform(info, response);
}

Future<Response> patch<T>(
  String uri, {
  Map<String, String>? headers,
  required dynamic body,
}) async {
  final info = "(PATCH) $uri";

  report(
    "Request $info\nRequestHeader $headers\nRequestBody ${const JsonEncoder.withIndent(" ").convert(body)}",
  );

  final response = await retry(
    () => http.patch(
      Uri.parse(uri),
      headers: headers,
      body: toBody(body),
    ),
  );

  return transform(info, response);
}

Future<Response> delete<T>(
  String uri, {
  Map<String, String>? headers,
  required dynamic body,
}) async {
  final info = "(DELETE) $uri";

  report(
    "Request (DELETE) $info\nRequestHeader $headers\nRequestBody ${const JsonEncoder.withIndent(" ").convert(body)}",
  );

  final response = await retry(
    () => http.delete(
      Uri.parse(uri),
      headers: headers,
      body: toBody(body),
    ),
  );

  return transform(info, response);
}

Future<Response> multipart(
  String uri, {
  Map<String, String>? headers,
  required File file,
}) async {
  final info = "(POST) $uri";

  report("Request $info\nRequestHeader $headers");

  final request = http.MultipartRequest("POST", Uri.parse(uri));

  if (headers != null) {
    request.headers.addAll(headers);
  }

  final split = file.path.split("/");

  final last = split[split.length - 1].split(".");

  final extension = last.length > 1 ? last[1] : "";

  final multipartFile = await http.MultipartFile.fromPath(
    "file",
    file.path,
    contentType: parser.MediaType("image", extension),
  );

  request.files.add(multipartFile);

  final stream = await request.send();

  final response = await retry(() => http.Response.fromStream(stream));

  return transform(info, response);
}
