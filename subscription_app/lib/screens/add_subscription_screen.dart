import 'package:flutter/material.dart';
import 'package:subscription_app/constants/auth.dart';
import 'package:subscription_app/constants/style.dart';
import 'package:subscription_app/widgets/form_add_subscription.dart';
import 'package:subscription_app/widgets/textFormFieldCustom.dart';

class AddSubscriptionScreen extends StatefulWidget {
  @override
  _AddSubscriptionScreenState createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: AppBar(
            iconTheme: IconThemeData(
              color: kSecondaryColor,
            ),
            backgroundColor: kMainBackground,
            elevation: 0,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 100),
          color: kMainBackground,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FormAddSubscription()),
        ),
      ]),
    );
  }
}
