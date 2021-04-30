import 'package:flutter/material.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(create: (context) => AppSettings()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          AuthScreen.id: (context) => AuthScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        },
        theme: ThemeData(),
        home:AuthScreen(),
      ),
    );
  }
}
