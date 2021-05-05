import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/services/app_state.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        TextButton(
          child: Text('logout'),
          onPressed: () {
            Provider.of<AppState>(context, listen: false).logout();
          },
        ),
        TextButton(
          child: Text('checkToken'),
          onPressed: () {
            Provider.of<AppState>(context, listen: false).checkToken();
          },
        ),
      ]),
    );
  }
}
