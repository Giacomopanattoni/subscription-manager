import 'package:flutter/material.dart';
import 'package:subscription_app/screens/socialLogin_screen.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppSettings(),
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          SocialLoginScreen.id: (context) => SocialLoginScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        },
        theme: ThemeData(),
        home: HomeScreen(),
      ),
    );
  }
}
