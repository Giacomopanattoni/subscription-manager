import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app/widgets/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* List<Widget> _buildScreens() {
    return [SubscriptionScreen(), AddSubscriptionScreen(), SettingsScreen()];
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF9B23EA),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background-home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
