import 'package:antenna_app/effects/types/when.dart';
import 'package:antenna_app/events/app_started.dart';
import 'package:antenna_app/plugins/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final initializeNotificationChannelEffect = when<AppStarted>((event) async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);

  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    ),
  );
});
