import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/widgets/elevatedButtonCutom.dart';
import 'package:subscription_app/widgets/socialButtonCustom.dart';
import 'package:subscription_app/widgets/textFormFieldCustom.dart';
import 'package:subscription_app/constants/style.dart';
import 'package:subscription_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailLoginController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();
  final passwordLoginController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameRegisterController = TextEditingController();
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

  void doLogin() async {
    String email = emailLoginController.text;
    String password = passwordLoginController.text;
    const _clientSecret = 'bVQwHIHugs8ZJl8PWVmd2taJ8297lQBW6ODrJIoF';
    const _clientId = '3';
    const _grantType = 'password';

    if (formKey.currentState.validate()) {
      dynamic params = {
        'username': email,
        'password': password,
        'client_secret': _clientSecret,
        'client_id': _clientId,
        'grant_type': _grantType,
      };
      final auth = Authentication();
      bool isLoginOk = await auth.login(params);
      print('isLoginOk');
      print(isLoginOk);

      if (isLoginOk) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    }
  }

  void doRegister() async {
    String name = userNameRegisterController.text;
    String email = emailRegisterController.text;
    String password = passwordRegisterController.text;

    if (formKey.currentState.validate()) {
      dynamic params = {
        'name': name,
        'username': email,
        'password': password,
      };
      final auth = Authentication();
      bool isRegOk = await auth.register(params);
      print('isRegOk');
      print(isRegOk);

      if (isRegOk) {
        switchLogReg(true);
      }
    }
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
          textController: emailLoginController,
          obscureText: false,
        ),
        SizedBox(
          height: 30,
        ),
        TextFormFieldCustom(
          hintText: 'Password',
          icon: Icons.remove_red_eye_sharp,
          textController: passwordLoginController,
          obscureText: true,
        ),
      ],
    );
    final register = Column(
      children: <Widget>[
        TextFormFieldCustom(
          hintText: 'User Name',
          icon: Icons.account_circle_outlined,
          textController: userNameRegisterController,
          obscureText: false,
        ),
        SizedBox(
          height: 30,
        ),
        TextFormFieldCustom(
          hintText: 'Email Address',
          icon: Icons.email_outlined,
          textController: emailRegisterController,
          obscureText: false,
        ),
        SizedBox(
          height: 30,
        ),
        TextFormFieldCustom(
          hintText: 'Password',
          icon: Icons.remove_red_eye_sharp,
          textController: passwordRegisterController,
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
      ],
    );

    final registerButtons = Column(
      children: <Widget>[
        SocialButtonCustom(
            textButton: 'REGISTER WITH GOOGLE',
            svgIconPath: 'images/googleicon.svg',
            onPress: () {}),
        SizedBox(
          height: 10,
        ),
        ElevatedButtonCustom(textButton: 'REGISTER', onPress: doRegister)
      ],
    );
    final loginButtons = Column(
      children: <Widget>[
        SocialButtonCustom(
            textButton: 'LOGIN WITH GOOGLE',
            svgIconPath: 'images/googleicon.svg',
            onPress: () {}),
        SizedBox(
          height: 10,
        ),
        ElevatedButtonCustom(textButton: 'LOGIN', onPress: doLogin)
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
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
                        height: 40,
                      ),
                      Form(
                        key: formKey,
                        child: isLogin ? login : register,
                      ),
                    ],
                  ),
                ),
              ),
              isLogin ? loginButtons : registerButtons,
            ],
          ),
        ),
      ),
    );
  }
}
