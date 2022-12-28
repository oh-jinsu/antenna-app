import 'package:antenna/effect.dart';
import 'package:antenna_app/debug/report.dart';
import 'package:antenna_app/events/app_started.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

var initializeFirebaseAnalytics = when<AppStarted>((event) async {
  if (await FirebaseAnalytics.instance.isSupported()) {
    report("Firebase analytics is supported");
  } else {
    report("Firebase analytics is not supported");
  }
});
