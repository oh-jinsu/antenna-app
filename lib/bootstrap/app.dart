import 'package:antenna_app/antenna_app.dart';
import 'package:antenna_app/events/app_lifecycle_state_changed.dart';
import 'package:flutter/material.dart';

class AntennaApp extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final ThemeData? theme;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;

  const AntennaApp({
    super.key,
    this.navigatorKey,
    required this.initialRoute,
    required this.onGenerateRoute,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.theme,
  });

  @override
  State<AntennaApp> createState() => _MyAppState();
}

class _MyAppState extends State<AntennaApp>
    with AntennaMixin, WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();

    dispatch(const AppStarted());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    dispatch(AppLifecycleStateChanged(state));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      theme: widget.theme,
      debugShowCheckedModeBanner: false,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
