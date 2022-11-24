abstract class Response {
  const Response();
}

class SuccessResponse extends Response {
  final dynamic body;

  const SuccessResponse({required this.body});

  T map<T>(T Function(dynamic) mapper) {
    return mapper(body);
  }
}

class FailureResponse extends Response {
  final int statusCode;
  final String message;

  const FailureResponse({
    required this.statusCode,
    required String? message,
  }) : message = message ?? "";
}
