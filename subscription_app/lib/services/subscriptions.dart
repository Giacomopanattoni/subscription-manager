import 'package:subscription_app/services/api.dart';
import 'package:subscription_app/models/subscription_model.dart';
import 'dart:convert';

class Subscriptions {
  Api api = Api();

  Future<dynamic> createSubscription(Subscription newSub) async {
    api.myPath = '/api/user-subscriptions/create';
    dynamic response = await api.post(jsonEncode(newSub.toJson()));

    return response;
  }

  Future<dynamic> getSubscription() async {
    api.myPath = '/api/user-subscriptions';
    dynamic data = await api.get();
    print(data);
    dynamic items = jsonDecode(data);
    List subscriptions = List<Subscription>.from(
        items['data'].map((model) => Subscription.fromJson(model)));

    return subscriptions ?? null;
  }
}
