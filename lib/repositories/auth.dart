import 'package:antenna_app/storages/secure.dart';

String? _accessToken;

String? findAccessToken() {
  return _accessToken;
}

void saveAccessToken(String value) {
  _accessToken = value;
}

void deleteAccessToken() {
  _accessToken = null;
}

const _refreshTokenKey = "refresh-token";

Future<String?> findRefreshToken() {
  return secureStorage.read(key: _refreshTokenKey);
}

Future<void> saveRefreshToken(String value) {
  return secureStorage.write(key: _refreshTokenKey, value: value);
}

Future<void> deleteRefreshToken() {
  return secureStorage.delete(key: _refreshTokenKey);
}
