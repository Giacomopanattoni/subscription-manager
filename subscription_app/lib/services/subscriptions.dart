import 'package:subscription_app/services/api.dart';
import 'package:subscription_app/models/subscription_model.dart';
import 'dart:convert';

class Subscriptions {
  Api api = Api();
//TODO ADD ERROR HANDLING
  Future<bool> createSubscription(dynamic newSub) async {
    api.myPath = '/api/user-subscriptions/create';
    dynamic response = await api.post(newSub);
    if (response != null) return true;
    return false;
  }

  Future<List<Subscription>> getSubscription() async {
    api.myPath = '/api/user-subscriptions';
    dynamic data = await api.get();
    if (data != null) {
      print(data);
      dynamic items = jsonDecode(data);
      List subscriptions = List<Subscription>.from(
          items['data'].map((model) => Subscription.fromJson(model)));

      return subscriptions;
    }
    return null;
  }
}
