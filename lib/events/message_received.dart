import 'package:firebase_messaging/firebase_messaging.dart';

class MessageReceived {
  final RemoteMessage message;

  const MessageReceived(this.message);
}
