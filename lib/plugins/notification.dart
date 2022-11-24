import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const androidNotificationChannel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.max,
);

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
