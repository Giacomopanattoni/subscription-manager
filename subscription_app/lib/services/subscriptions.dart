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
      print(data);
      dynamic items = jsonDecode(data);
      List subscriptions = List<Subscription>.from(
          items['data'].map((model) => Subscription.fromJson(model)));

      return subscriptions;
    }
    return null;
  }

  Future<bool> editSubscription(dynamic params, String idSub) async {
    String myPath = '/api/user-subscriptions/$idSub';
    dynamic response = await api.post(path: myPath);
    if (response != null) return true;
    return false;
  }
}
