import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/services/app_data.dart';
import 'package:subscription_app/widgets/subscription_widget.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background-home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView.builder(
        itemCount: Provider.of<AppData>(context).subscriptions.length,
        itemBuilder: (context, index) {
          return SubscriptionWidget(
            subscription: Provider.of<AppData>(context).subscriptions[index],
          );
        },
      ),
    );
  }
}
