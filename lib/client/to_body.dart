import 'dart:convert';

String toBody(dynamic body) {
  if (body is Map) {
    return jsonEncode(body);
  }

  return body;
}
