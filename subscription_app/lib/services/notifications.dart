import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:subscription_app/constants/auth.dart';
import 'package:subscription_app/services/api.dart';

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
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<String> getTokenFire() async {
    try {
      await Firebase.initializeApp();
      messaging = FirebaseMessaging.instance;
      String token = await messaging.getToken(vapidKey: kVapidKey);
      return token;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<bool> chanelNotification({String tokenFire}) async {
    Api api = Api();
    String myPath = '/api/device/add';
    dynamic param = {'token': tokenFire};
    dynamic data = await api.post(path: myPath, body: param);
    if (data != null) {
      print(data);
      return true;
    }
    return false;
  }
}
