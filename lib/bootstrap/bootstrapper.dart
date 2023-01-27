import 'package:antenna/antenna.dart';
import 'package:antenna_app/effects/background_message.dart';
import 'package:antenna_app/effects/initialize_analytics.dart';
import 'package:antenna_app/effects/initialize_messaging.dart';
import 'package:antenna_app/effects/initialize_notification_channel.dart';
import 'package:antenna_app/effects/load_env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Bootstrapper {
  final FirebaseOptions firebaseOptions;
  final Iterable<Store> stores;
  final Iterable<Effect> effects;

  const Bootstrapper({
    required this.firebaseOptions,
    required this.stores,
    required this.effects,
  });

  Future<void> bootstrap(Widget app, [Effect? listener]) async {
    WidgetsFlutterBinding.ensureInitialized();

    final subscription = listenEffect((event) {
      listener?.call(event);
    });

    stores.forEach(connectStore);

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

    runApp(app);
  }
}
