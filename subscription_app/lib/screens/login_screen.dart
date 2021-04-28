import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app/widgets/textFormFieldCustom.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subscription_app/constants/style.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  double endIndentDivider;
  double indentDivider;
  bool isLogin;
  Color colorRegText;
  Color colorLogText;

  void switchLogReg(bool screenState) {
    setState(() {
      isLogin = screenState;
      endIndentDivider = isLogin ? 170 : 0;
      indentDivider = isLogin ? 0 : 170;
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
    final login = Column(
      children: <Widget>[
        TextFormFieldCustom(
          hintText: 'Email Address',
          icon: Icons.email_outlined,
          textController: emailController,
          obscureText: false,
        ),
        SizedBox(
          height: 30,
        ),
        TextFormFieldCustom(
          hintText: 'Password',
          icon: Icons.remove_red_eye_sharp,
          textController: passwordController,
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Container(
            width: 350,
            height: 45,
            child: Row(
              children: [
                SvgPicture.asset(
                  'images/googleicon.svg',
                  width: 30,
                  height: 30,
                ),
                Text(
                  'LOGIN WITH GOOGLE',
                  style: TextStyle(
                    color: kTextColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff9b23ea), Color(0xff391792)]),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 350,
              height: 45,
              alignment: Alignment.center,
              child: Text(
                'LOGIN',
              ),
            ),
          ),
        ),
      ],
    );
    final register = Column(
      children: <Widget>[
        TextFormFieldCustom(
          hintText: 'Email Address',
          icon: Icons.email_outlined,
          textController: emailController,
          obscureText: false,
        ),
        SizedBox(
          height: 30,
        ),
        TextFormFieldCustom(
          hintText: 'Password',
          icon: Icons.remove_red_eye_sharp,
          textController: passwordController,
          obscureText: true,
        ),
        SizedBox(
          height: 30,
        ),
        TextFormFieldCustom(
          hintText: 'Confirm password',
          icon: Icons.remove_red_eye_sharp,
          textController: confirmPasswordController,
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff9b23ea), Color(0xff391792)]),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 350,
              height: 45,
              alignment: Alignment.center,
              child: Text(
                'REGISTER',
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
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
                    Divider(
                      thickness: 2,
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: endIndentDivider,
                      indent: indentDivider,
                      color: kColorPrimary,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                isLogin ? login : register,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
