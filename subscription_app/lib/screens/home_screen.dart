import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app/screens/login_screen.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'package:subscription_app/services/language.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void traduci() async {
    Provider.of<AppSettings>(context, listen: false).lang = Language.it;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Center(
            child: Container(
              child: Text(
                  Provider.of<AppSettings>(context).multiLangString('welcome')),
            ),
          ),
          TextButton(
            onPressed: () {
              traduci();
            },
            child: Text('Traduci in es'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            child: Text('Login'),
          )
        ],
      ),
    );
  }
}
