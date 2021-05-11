import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/constants/style.dart';
import 'package:subscription_app/services/app_session.dart';
import 'package:subscription_app/services/authentication.dart';

class LoginController {
  void doLogin(context, email, password) async {
    showLoaderDialog(context);
    bool logged = await Provider.of<AppSession>(context, listen: false)
        .login(email, password);
    Navigator.pop(context);
    if (!logged) await showMyDialog(context);
  }

  void doLoginWithGoogle(context) async {
    String googleToken = await Authentication.signInWithGoogle();
    showLoaderDialog(context);
    bool logged = await Provider.of<AppSession>(context, listen: false)
        .googleLogin(googleToken);
    Navigator.pop(context);
    if (!logged) await showMyDialog(context);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.error,
            color: kColorError,
            size: 70,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Opss..'),
                Text('Please check your credentials and try again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: kTextColorDark)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
