String? host;

void setHost(String value) {
  host = value;
}

String endpoint(String value) {
  return "$host/$value";
}
