import 'package:antenna/antenna.dart';
import 'package:antenna/store.dart';
import 'package:antenna_app/effects/attach_message_listener.dart';
import 'package:antenna_app/effects/background_message.dart';
import 'package:antenna_app/effects/initialize_analytics.dart';
import 'package:antenna_app/effects/initialize_messaging.dart';
import 'package:antenna_app/effects/initialize_notification_channel.dart';
import 'package:antenna_app/effects/load_env.dart';
import 'package:antenna_app/effects/types/effect.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Bootstrapper {
  final FirebaseOptions firebaseOptions;
  final List<Store> stores;
  final List<Effect> effects;

  const Bootstrapper({
    required this.firebaseOptions,
    required this.stores,
    required this.effects,
  });

  Future<void> bootstrap(Widget app, [Effect? listener]) async {
    WidgetsFlutterBinding.ensureInitialized();

    final subscription = listen((event) {
      listener?.call(event);
    });

    stores.forEach(connect);

    listen(loadEnvEffect);
    listen(initializeMessagingEffect);
    listen(initializeNotificationChannelEffect);
    listen(initializeFirebaseAnalytics);
    listen(attachMessageListenerEffect);

    effects.forEach(listen);

    await Firebase.initializeApp(options: firebaseOptions);

    FirebaseMessaging.onBackgroundMessage(backgroundMessageEffect);

    subscription.cancel();

    runApp(app);
  }
}
