import 'package:antenna/antenna.dart';
import 'package:antenna_app/events/message_received.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundMessageEffect(RemoteMessage message) async {
  dispatch(MessageReceived(message.data));
}
