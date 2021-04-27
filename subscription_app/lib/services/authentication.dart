import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_app/services/api.dart';

class Authentication {
  Api api = Api();
//TODO ADD ERROR HANDLING
  Future<bool> register(dynamic params) async {
    api.myPath = '/api/auth/register';
    dynamic data = await api.post(params);
    if (data != null) {
      dynamic dataDecode = jsonDecode(data);
      print(dataDecode);
      return true; //TODO after register go to login page
    }
    return false;
  }

  Future<bool> login(dynamic params) async {
    api.myPath = '/api/auth/token';
    dynamic data = await api.post(params);
    if (data != null) {
      dynamic dataDecode = jsonDecode(data);
      myPref(dataDecode);
      return true;
    }
    return false;
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
