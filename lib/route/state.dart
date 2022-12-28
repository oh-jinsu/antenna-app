import 'package:antenna/antenna.dart';
import 'package:antenna_app/events/alerted.dart';
import 'package:flutter/material.dart';

abstract class RouteState<T extends StatefulWidget> extends State<T>
    with AntennaMixin {
  @override
  void initState() {
    listen((event) {
      if (event is Alerted) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          showAlertDialog(event.title, event.message);
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
