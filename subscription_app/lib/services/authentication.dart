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
    String myPath = '/api/auth/register';
    dynamic data = await api.post(path: myPath, body: params);
    if (data != null) {
      print(data);
      return true;
    }
    return false;
  }

  Future<bool> login(dynamic params) async {
    String myPath = '/api/auth/token';
    dynamic data = await api.post(path: myPath, body: params);
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

  static Future<String> signInWithGoogle() async {
    Firebase.initializeApp();
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().disconnect();
    }
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return googleAuth.accessToken;
  }
}
