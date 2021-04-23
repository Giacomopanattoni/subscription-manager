import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  String path;

  final String _baseUrl = "10.0.2.2";

  Api({this.path});

  set myPath(String newPath) {
    path = newPath;
  }

  Future<dynamic> get() async {
    String token = await prefToken;
    try {
      final response = await http.get(
        Uri.http(_baseUrl, path),
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

  Future<dynamic> post(dynamic body) async {
    print(body);
    String token = await prefToken;
    try {
      final response = await http.post(Uri.http(_baseUrl, path),
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);

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
