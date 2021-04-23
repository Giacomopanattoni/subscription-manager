import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_app/services/api.dart';

class Authentication {
  Api api = Api();
  Future<dynamic> register(dynamic params) async {
    api.myPath = '/api/auth/register';
    dynamic data = await api.post(params);
    dynamic dataDecode = jsonDecode(data);
    print(dataDecode);
    myPref(dataDecode);
    return data ?? null;
  }

  Future<dynamic> login(dynamic params) async {
    api.myPath = '/api/auth/token';
    dynamic data = await api.post(params);
    dynamic dataDecode = jsonDecode(data);
    print(dataDecode);
    myPref(dataDecode);
    return data ?? null;
  }

  void myPref(dynamic authData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = authData['access_token'];
    int expires = authData['expires_in'];
    String refreshToken = authData['refresh_token'];

    pref.setString('myToken', token);
    pref.setInt('expires', expires);
    pref.setString('refreshToken', refreshToken);
  }
}
