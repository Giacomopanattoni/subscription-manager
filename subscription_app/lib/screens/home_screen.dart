import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/constants/style.dart';
import 'package:subscription_app/screens/add_subscription_screen.dart';
import 'package:subscription_app/screens/settings_screen.dart';
import 'package:subscription_app/screens/subscription_screen.dart';
import 'package:subscription_app/services/app_data.dart';
import 'package:subscription_app/widgets/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    SubscriptionScreen(),
    SettingsScreen(),
  ];

  int currentPage = 0;

  void changePage(index) {
    setState(() {
      if (index == pages.length) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddSubscriptionScreen()),
        );
      } else {
        currentPage = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppData>(create: (context) => AppData()),
      ],
      child: Scaffold(
          backgroundColor: kMainBackground,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              changePage(pages.length);
            },
            backgroundColor: kSecondaryColor,
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
          bottomNavigationBar: BottomBar(
            currentIndex: currentPage,
            onChange: changePage,
          ),
          body: pages[currentPage]),
    );
  }
}
