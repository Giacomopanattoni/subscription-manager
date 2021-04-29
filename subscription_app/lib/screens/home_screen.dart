import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/services/currencies.dart';
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
              onPressed: () async {
                await Subscriptions().getSubscription();
              },
              child: Text('Get Subs'),
            ),
            TextButton(
              onPressed: () async {
                dynamic params = {
                  'username': 'kevinmateo-rodriguez@hotmail.com',
                  'password': '123456',
                  'client_id': '3',
                  'client_secret': 'ha6ev4v0ZDityQfyDRl0mlTLzT4kSwyPeKXP8Z4N',
                  'grant_type': 'password'
                };
                await Authentication().login(params);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () async {
                await Currencies().getCurrencies();
              },
              child: Text('Get Currencies '),
            ),
            TextButton(
              onPressed: () async {
                dynamic params = {
                  'name': 'Kevin',
                  'password': '123456',
                  'email': 'kevinmateo-rodriguez@hotmail.com',
                };

                await Authentication().register(params);
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () async {
                dynamic newSub = {
                  'name': 'Camper&Motori',
                  'price': '666',
                  'renewal_day': '15',
                  'every_count': '1',
                  'every_item': 'month',
                  'from': '10-03-2021',
                  'notify': '1'
                };
                await Subscriptions().createSubscription(newSub);
              },
              child: Text('Create a Sub'),
            ),
            TextButton(
              onPressed: () {
                Authentication.signInWithGoogle();
              },
              child: Text('Google Login'),
            )
          ],
        ),
      ),
    );
  }
}
