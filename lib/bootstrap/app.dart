import 'package:antenna_app/antenna_app.dart';
import 'package:antenna_app/events/app_lifecycle_state_changed.dart';
import 'package:flutter/material.dart';

abstract class AppState<T extends StatefulWidget> extends State<T>
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
}
