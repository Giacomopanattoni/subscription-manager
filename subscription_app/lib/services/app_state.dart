import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_app/constants/auth.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/services/notifications.dart';

class AppState extends ChangeNotifier {
  SharedPreferences pref;
  String token;
  String refreshToken;

  AppState() {
    print('LOADING...');
    loadData();
  }

  Future<void> loadData() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('myToken');
    refreshToken = pref.getString('refreshToken');
    if (token != null) {
      await checkToken();
    }
    notifyListeners();
  }

  Future<void> checkToken() async {
    dynamic tokenSplit = token.split(".");
    dynamic payload = json
        .decode(ascii.decode(base64.decode(base64.normalize(tokenSplit[1]))));
    if (DateTime.fromMillisecondsSinceEpoch(payload["exp"].toInt() * 1000)
        .isAfter(DateTime.now())) {
      return true;
    } else {
      refresh();
      print('refreshed');
    }
  }

  Future<bool> login(String email, String password) async {
    dynamic params = {
      'username': email,
      'password': password,
      'client_secret': kClientSecret,
      'client_id': kClientId,
      'grant_type': kGrantTypePassword,
    };
    final auth = Authentication();
    dynamic userData = await auth.login(params);
    if (userData != null) {
      await storeUserData(userData);
      await sendDeviceToken();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> googleLogin(googleToken) async {
    dynamic params = {
      'client_id': kClientId,
      'client_secret': kClientSecret,
      'provider': kProviderGoogle,
      'grant_type': kGrantTypeSocial,
      'access_token': googleToken
    };
    final auth = Authentication();
    dynamic userData = await auth.login(params);
    if (userData != null) {
      await storeUserData(userData);
      await sendDeviceToken();
      return true;
    } else {
      return false;
    }
  }

  Future<void> storeUserData(userData) async {
    print('STORING DATA...');
    token = userData['access_token'];
    refreshToken = userData['refresh_token'];
    print(token);

    pref.setString('myToken', token);
    pref.setString('refreshToken', refreshToken);
  }

  Future<void> sendDeviceToken() async {
    Notifications notify = Notifications();
    String tokenFire = await notify.getTokenFire();
    await notify.chanelNotification(tokenFire: tokenFire);
    notifyListeners();
  }

  Future<void> refresh() async {
    if (refreshToken == null) logout();
    final auth = Authentication();
    dynamic params = {
      'client_id': kClientId,
      'client_secret': kClientSecret,
      'grant_type': kGrantTypeRefresh,
      'refresh_token': refreshToken,
    };
    dynamic userData = await auth.login(params);
    if (userData != null) {
      await storeUserData(userData);
    } else {
      logout();
    }
  }

  void logout() {
    pref.clear();
    token = null;
    refreshToken = null;
    notifyListeners();
  }
}
