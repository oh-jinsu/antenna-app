import 'package:antenna/antenna.dart';
import 'package:antenna/effect.dart';
import 'package:antenna_app/debug/report.dart';
import 'package:antenna_app/events/app_started.dart';
import 'package:antenna_app/events/env_intialized.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var loadEnvEffect = when<AppStarted>((event) async {
  if (kDebugMode) {
    await dotenv.load(fileName: ".env.local");
  } else {
    await dotenv.load(fileName: ".env");
  }

  report("Env loaded");

  dispatch(const EnvInitialized());
});
