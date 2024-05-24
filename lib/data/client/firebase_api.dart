import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token FCM: $fCMToken');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcm-token', fCMToken!);
    FirebaseMessaging.onBackgroundMessage((handleBackgroundMessage));
  }
}
