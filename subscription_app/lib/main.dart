import 'package:flutter/material.dart';
import 'package:subscription_app/services/appSettings.dart';
import 'package:subscription_app/services/app_session.dart';
import 'package:subscription_app/widgets/spinner.dart';
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
        ChangeNotifierProvider<AppSession>(create: (context) => AppSession()),
      ],
      child: Consumer<AppSession>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'Translation App',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            debugShowCheckedModeBanner: false,
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
