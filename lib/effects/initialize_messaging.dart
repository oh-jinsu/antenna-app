import 'package:antenna/antenna.dart';
import 'package:antenna_app/events/app_started.dart';
import 'package:antenna_app/events/message_received.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final initializeMessagingEffect = when<AppStarted>((event) async {
  final messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await messaging.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );

  final initialMessage = await messaging.getInitialMessage();

  if (initialMessage != null) {
    dispatch(MessageReceived(initialMessage));
  }

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    dispatch(MessageReceived(message));
  });

  FirebaseMessaging.onMessage.listen((message) {
    dispatch(MessageReceived(message));
  });
});
