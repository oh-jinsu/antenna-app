import 'dart:convert';

dynamic toBody(dynamic body) {
  if (body is Map) {
    return jsonEncode(body);
  }

  return body;
}
