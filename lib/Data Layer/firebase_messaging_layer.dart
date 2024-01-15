import 'package:firebase_messaging/firebase_messaging.dart';

class AppMessaging{
  AppMessaging._();
  static Stream<RemoteMessage> foregroundMessageStream = FirebaseMessaging.onMessage;
}