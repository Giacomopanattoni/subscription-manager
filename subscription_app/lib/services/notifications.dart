import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';

class Notifications {
  Echo echo;

  Notifications() {
    initPusher();
  }

  void initPusher() {
    PusherOptions options = PusherOptions(
      host: 'subscriptionmanager.foolstack.app',
      wssPort: 6001,
      encrypted: true,
    );
    PusherClient pusher =
        PusherClient('subscriptionmanager', options, autoConnect: true);

    echo = new Echo({
      'broadcaster': 'pusher',
      'client': pusher,
    });

    echo.channel('user').listen('.user.channel', (PusherEvent e) {
      print(e.data);
      //TODO implementare notifiche
    });
  }
}
