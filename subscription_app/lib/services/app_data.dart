import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_app/models/subscription_model.dart';
import 'package:subscription_app/services/subscriptions.dart';

class AppData extends ChangeNotifier {
  SharedPreferences pref;
  List<Subscription> subscriptions = [];

  AppData() {
    loadData();
  }

  Future<void> loadData() async {
    pref = await SharedPreferences.getInstance();
    Subscriptions subscriptionService = Subscriptions();
    subscriptions = await subscriptionService.getSubscription();
    notifyListeners();
  }

  Future<void> changeNotify(Subscription subscription) async {
    subscription.notify = !subscription.notify;
    Subscriptions subscriptionService = Subscriptions();
    var res = await subscriptionService.editSubscription(subscription);
    print('Status--------------');
    print(res);
    loadData();
  }
}
