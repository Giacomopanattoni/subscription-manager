import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final String _baseUrl = 'subscriptionmanager.foolstack.app';

  Future<dynamic> get({String path}) async {
    String token = await prefToken;
    try {
      final response = await http.get(
        Uri.https(_baseUrl, path),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print('Error $e');
      return null;
    }
  }

  Future<dynamic> post({dynamic body,String path}) async {
    print(body);
    String token = await prefToken;
    try {
      final response = await http.post(Uri.https(_baseUrl, path),
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;

        return data;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print('Error $e');
      return null;
    }
  }

  Future<String> get prefToken async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('myToken');
    return token ?? null;
  }
}
