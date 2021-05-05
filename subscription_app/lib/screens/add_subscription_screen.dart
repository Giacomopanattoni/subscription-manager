import 'package:flutter/material.dart';
import 'package:subscription_app/constants/style.dart';

class AddSubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: kMainBackground,
          child: Center(
            child: Text('add subscription'),
          ),
        ),
        Positioned(
          child: AppBar(
            iconTheme: IconThemeData(
              color: kSecondaryColor,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        )
      ]),
    );
  }
}
