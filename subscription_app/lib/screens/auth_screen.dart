import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app/widgets/loginWidget.dart';
import 'package:subscription_app/widgets/registerWidget.dart';
import 'package:subscription_app/constants/style.dart';

class AuthScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Color dividerLoginColor;
  Color dividerRegisterColor;
  bool isLogin;
  Color colorRegText;
  Color colorLogText;

  void switchLogReg(bool screenState) {
    setState(() {
      isLogin = screenState;
      dividerLoginColor = isLogin ? kColorPrimary : Colors.transparent;
      dividerRegisterColor = isLogin ? Colors.transparent : kColorPrimary;
      colorLogText = isLogin ? kColorPrimary : kTextColorDark;
      colorRegText = isLogin ? kTextColorDark : kColorPrimary;
    });
  }

  @override
  void initState() {
    switchLogReg(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            switchLogReg(true);
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: colorLogText),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            switchLogReg(false);
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(color: colorRegText),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Divider(thickness: 2),
                        Divider(
                          thickness: 2,
                          endIndent: MediaQuery.of(context).size.width / 2,
                          color: dividerLoginColor,
                        ),
                        Divider(
                          thickness: 2,
                          indent: MediaQuery.of(context).size.width / 2,
                          color: dividerRegisterColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isLogin ? LoginWidget() : RegisterWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
