import 'package:antenna/antenna.dart';
import 'package:antenna_app/effects/types/when.dart';
import 'package:antenna_app/events/app_started.dart';
import 'package:antenna_app/events/message_received.dart';
import 'package:antenna_app/plugins/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    alert: true,
    badge: true,
    sound: true,
  );

  final initialMessage = await messaging.getInitialMessage();

  if (initialMessage != null) {
    dispatch(MessageReceived(initialMessage.data));
  }

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    dispatch(MessageReceived(message.data));
  });

  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidNotificationChannel.id,
            androidNotificationChannel.name,
            icon: android?.smallIcon,
          ),
        ),
      );
    }

    dispatch(MessageReceived(message.data));
  });
});
