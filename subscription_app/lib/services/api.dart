import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final String path;
  final String token;
  final String _baseUrl = "127.0.0.1:8000";

  Api({this.path, this.token});

  Future<dynamic> get() async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, path),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Authorization': 'Bearer $token'
        },
      );

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

  Future<dynamic> post(dynamic body) async {
    try {
      final response = await http.post(Uri.http(_baseUrl, path),
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body));

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
}
