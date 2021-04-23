import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'package:subscription_app/services/languages.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    void traduci() async {
      Provider.of<AppSettings>(context, listen: false).lang = 'en';
    }

    return Scaffold(
      body: Row(
        children: [
          Center(
            child: Container(
              child: Text(
                  Provider.of<AppSettings>(context).multiLangString('hello')),
            ),
          ),
          TextButton(
            onPressed: () {
              traduci();
            },
            child: Text('Traduci in en'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('back'),
          )
        ],
      ),
    );
  }
}
