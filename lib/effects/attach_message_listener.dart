import 'package:antenna/antenna.dart';
import 'package:antenna_app/client/endpoint.dart';
import 'package:antenna_app/client/http.dart';
import 'package:antenna_app/client/response.dart';
import 'package:antenna_app/effects/types/when.dart';
import 'package:antenna_app/events/auth_refresh_resolved.dart';
import 'package:antenna_app/events/messaging_listener_submitted.dart';
import 'package:antenna_app/functions/with_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final attachMessageListenerEffect = when<AuthRefreshResolved>((event) async {
  final messaging = FirebaseMessaging.instance;

  final token = await messaging.getToken();

  if (token != null) {
    await _sendToken(token);
  }

  messaging.onTokenRefresh.listen(_sendToken);
});

Future<void> _sendToken(String token) async {
  final response = await withAuth(
    (accessToken) => post(
      endpoint("listeners"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      body: {
        "device_token": token,
      },
    ),
  );

  if (response is SuccessResponse) {
    dispatch(const MessageListenerAttached());
  }
}
