import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
  FirebaseMessaging messaging;

  Notifications() {
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    var token = await messaging.getToken(
        vapidKey:
            'BNjvyIliQfb-zOTWRVVTRM4ebCLNQ_ZfRCAHgPkE2TSTz8wK29nC7jRAzfuo7zXvPBK6_HHlXfTQ7xx_vQ5YnFg');
    print(token);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
