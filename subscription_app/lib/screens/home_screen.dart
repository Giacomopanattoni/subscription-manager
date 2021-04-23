import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app/screens/login_screen.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/services/currencies.dart';
import 'package:subscription_app/services/languages.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/services/subscriptions.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                child: Text(Provider.of<AppSettings>(context)
                    .multiLangString('welcome')),
              ),
            ),
            TextButton(
              onPressed: () {
                Subscriptions().getSubscription();
              },
              child: Text('Get Subs'),
            ),
            TextButton(
              onPressed: () {
                dynamic params = {
                  'username': 'kevinmateo-rodriguez@hotmail.com',
                  'password': 'admin',
                  'client_id': '1',
                  'client_secret': 'qzSLIHEpwzYpYsV8GHgZKDtLttultFDvIyk6DGEw',
                  'grant_type': 'password',
                };
                Authentication().login(params);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () async {
                Currencies().getCurrencies();
              },
              child: Text('Get Currencies '),
            ),
            TextButton(
              onPressed: () async {
                dynamic params = {
                  'name': 'Gino',
                  'password': '123456',
                  'email': 'gino2@live.it',
                };

                Authentication().register(params);
              },
              child: Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
