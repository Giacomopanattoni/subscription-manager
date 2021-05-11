import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/services/app_session.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(children: [
          TextButton(
            child: Text('logout'),
            onPressed: () {
              Provider.of<AppSession>(context, listen: false).logout();
            },
          ),
          TextButton(
            child: Text('checkToken'),
            onPressed: () {
              Provider.of<AppSession>(context, listen: false).checkToken();
            },
          ),
        ]),
      ),
    );
  }
}
