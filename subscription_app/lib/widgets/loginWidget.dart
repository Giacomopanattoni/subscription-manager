import 'package:flutter/material.dart';
import 'package:subscription_app/widgets/textFormFieldCustom.dart';
import 'package:subscription_app/widgets/socialButtonCustom.dart';
import 'package:subscription_app/widgets/elevatedButtonCutom.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/screens/home_screen.dart';
import 'package:subscription_app/constants/auth.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  void doLogin() async {
    String email = emailLoginController.text;
    String password = passwordLoginController.text;

    if (formKey.currentState.validate()) {
      dynamic params = {
        'username': email,
        'password': password,
        'client_secret': kClientSecret,
        'client_id': kClientId,
        'grant_type': kGrantTypePassword,
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

  void doLoginWithGoogle() async {
    String googleToken = await Authentication.signInWithGoogle();
    print('googleToken');
    print(googleToken);
    dynamic params = {
      'client_id': kClientId,
      'client_secret': kClientSecret,
      'provider': kProviderGoogle,
      'grant_type': kGrantTypeSocial,
      'access_token': googleToken
    };
    final auth = Authentication();
    bool isLoginOk = await auth.login(params);
    print('isLoginOk');
    print(isLoginOk);

    if (isLoginOk) {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
  }

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginButtons = Column(
      children: <Widget>[
        SocialButtonCustom(
            textButton: 'LOGIN WITH GOOGLE',
            svgIconPath: 'images/googleicon.svg',
            onPress: () {
              doLoginWithGoogle();
            }),
        SizedBox(
          height: 10,
        ),
        ElevatedButtonCustom(textButton: 'LOGIN', onPress: doLogin)
      ],
    );

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormFieldCustom(
            hintText: 'Email Address',
            icon: Icons.email_outlined,
            textController: emailLoginController,
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormFieldCustom(
            hintText: 'Password',
            icon: Icons.remove_red_eye_sharp,
            textController: passwordLoginController,
            obscureText: true,
          ),
          SizedBox(
            height: 100,
          ),
          loginButtons
        ],
      ),
    );
  }
}
