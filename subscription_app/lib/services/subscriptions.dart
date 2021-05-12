import 'dart:developer';

import 'package:subscription_app/services/api.dart';
import 'package:subscription_app/models/subscription_model.dart';
import 'dart:convert';

class Subscriptions {
  Api api = Api();
//TODO ADD ERROR HANDLING
  Future<bool> createSubscription(dynamic newSub) async {
    String myPath = '/api/user-subscriptions/create';
    dynamic response = await api.post(path: myPath);
    if (response != null) return true;
    return false;
  }

  Future<List<Subscription>> getSubscription() async {
    String myPath = '/api/user-subscriptions';
    dynamic data = await api.get(path: myPath);
    if (data != null) {
      dynamic items = jsonDecode(data);
      List subscriptions = List<Subscription>.from(
          items['data'].map((model) => Subscription.fromJson(model)));
      return subscriptions;
    }
    return null;
  }

  Future<bool> editSubscription(Subscription subscription) async {
    String subId = subscription.id.toString();
    print('SUB-----------------');
    print(subscription);
    print('SUBJSON-----------------');
    print(jsonEncode(subscription.toJson()));
    dynamic data = await api.post(
        path: '/api/user-subscriptions/$subId',
        body: jsonEncode(subscription.toJson()));
    if (data != null) {
      return true;
    }
    return false;
  }
}
