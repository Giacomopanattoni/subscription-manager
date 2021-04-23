import 'api.dart';

class Currencies {
  Future<dynamic> getCurrencies() async {
    Api api = Api(path: '/api/currencies');
    dynamic data = await api.get();
    print(data);
    return data ?? null;
  }
}
