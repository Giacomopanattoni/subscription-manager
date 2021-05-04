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
  Color _dividerLoginColor = kColorPrimary;
  Color _dividerRegisterColor = Colors.transparent;
  Color _colorRegText = kTextColorDark;
  Color _colorLogText = kColorPrimary;

  void switchLogReg(int pageScreen) {
    setState(() {
      bool isLogin;
      pageScreen == 0 ? isLogin = true : isLogin = false;
      isLogin ? controller.jumpToPage(0) : controller.jumpToPage(1);
      _dividerLoginColor = isLogin ? kColorPrimary : Colors.transparent;
      _dividerRegisterColor = isLogin ? Colors.transparent : kColorPrimary;
      _colorLogText = isLogin ? kColorPrimary : kTextColorDark;
      _colorRegText = isLogin ? kTextColorDark : kColorPrimary;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          switchLogReg(0);
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: _colorLogText),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          switchLogReg(1);
                        },
                        child: Text(
                          'REGISTER',
                          style: TextStyle(color: _colorRegText),
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
                        color: _dividerLoginColor,
                      ),
                      Divider(
                        thickness: 2,
                        indent: MediaQuery.of(context).size.width / 2,
                        color: _dividerRegisterColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageView(
                      onPageChanged: (int) {
                        switchLogReg(int);
                      },
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      children: [
                        LoginWidget(),
                        RegisterWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
