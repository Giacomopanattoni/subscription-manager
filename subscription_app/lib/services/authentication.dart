import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_app/services/api.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    Firebase.initializeApp();

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(googleAuth.accessToken);
  }
}
