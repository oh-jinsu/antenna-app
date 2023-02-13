import 'package:antenna/antenna.dart';
import 'package:antenna_app/effects/background_message.dart';
import 'package:antenna_app/effects/initialize_analytics.dart';
import 'package:antenna_app/effects/initialize_messaging.dart';
import 'package:antenna_app/effects/initialize_notification_channel.dart';
import 'package:antenna_app/effects/load_env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap({
  required FirebaseOptions firebaseOptions,
  required Iterable<Store> stores,
  required Iterable<Effect> effects,
  Effect? listener,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  stores.forEach(connectStore);

  final subscription = listenEffect((event) {
    listener?.call(event);
  });

  [
    loadEnvEffect,
    initializeMessagingEffect,
    initializeNotificationChannelEffect,
    initializeFirebaseAnalytics,
    ...effects
  ].forEach(listenEffect);

  await Firebase.initializeApp(options: firebaseOptions);

  FirebaseMessaging.onBackgroundMessage(backgroundMessageEffect);

  subscription.cancel();
}
