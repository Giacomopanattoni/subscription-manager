import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:subscription_app/services/api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  Api api = Api();

//TODO ADD ERROR HANDLING
  Future<bool> register(dynamic params) async {
    dynamic data = await api.post(path: '/api/auth/register', body: params);
    if (data != null) {
      return true;
    }
    return false;
  }

  Future<dynamic> login(dynamic params) async {
    dynamic data = await api.post(path: '/api/auth/token', body: params);
    if (data != null) {
      dynamic dataDecode = jsonDecode(data);
      return dataDecode;
    }
    return null;
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
