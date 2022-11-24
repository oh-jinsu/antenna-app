import 'package:antenna/antenna.dart';
import 'package:antenna_app/events/alerted.dart';
import 'package:antenna_app/events/auth_needed.dart';
import 'package:flutter/material.dart';

abstract class RouteState<T extends StatefulWidget> extends State<T>
    with AntennaManager {
  @override
  void initState() {
    $listen((event) {
      if (event is Alerted) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          showAlertDialog(event.title, event.message);
        }
      }

      if (event is AuthNeeded) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).pushNamed("/apply");
        }
      }
    });

    super.initState();
  }

  Future<void> showAlertDialog(String title, String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }
}
