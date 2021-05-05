import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'package:subscription_app/services/app_state.dart';
import 'package:subscription_app/widgets/spinner.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/constants/auth.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

Future<bool> get isTokenValid async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('myToken');
  String refreshToken = pref.getString('refreshToken');

  if (token == null || token == '') {
    return false;
  } else {
    dynamic tokenSplit = token.split(".");
    dynamic payload = json
        .decode(ascii.decode(base64.decode(base64.normalize(tokenSplit[1]))));
    print(DateTime.fromMillisecondsSinceEpoch(payload["exp"].toInt() * 1000));
    if (DateTime.fromMillisecondsSinceEpoch(payload["exp"].toInt() * 1000)
        .isAfter(DateTime.now())) {
      return true;
    } else {
      if (refreshToken == null || refreshToken == '') {
        return false;
      } else {
        final auth = Authentication();
        dynamic params = {
          'client_id': kClientId,
          'client_secret': kClientSecret,
          'grant_type': kGrantTypeRefresh,
          'refresh_token': refreshToken,
        };
        bool isLoginOK = await auth.login(params);

        return isLoginOK;
      }
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(create: (context) => AppSettings()),
        ChangeNotifierProvider<AppState>(create: (context) => AppState()),
      ],
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'Translation App',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: state.token != null ? HomeScreen() : AuthScreen(),
            routes: <String, WidgetBuilder>{
              AuthScreen.id: (context) => AuthScreen(),
              HomeScreen.id: (context) => HomeScreen(),
            },
          );
        },
      ),
    );
  }
}
