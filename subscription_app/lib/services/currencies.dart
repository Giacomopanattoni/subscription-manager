import 'api.dart';
import 'package:subscription_app/models/currency_model.dart';
import 'dart:convert';

class Currencies {
  Api api = Api();
//TODO ADD ERROR HANDLING
  Future<dynamic> getCurrencies() async {
    api.myPath = '/api/currencies';
    dynamic data = await api.get();
    if (data != null) {
      dynamic items = jsonDecode(data);
      print(items);
      List currencies =
          List<Currency>.from(items.map((model) => Currency.fromJson(model)));
      return currencies;
    }
    return null;
  }
}
