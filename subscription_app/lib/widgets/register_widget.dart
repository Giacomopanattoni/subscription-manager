import 'package:flutter/material.dart';
import 'package:subscription_app/widgets/textFormFieldCustom.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/widgets/socialButtonCustom.dart';
import 'package:subscription_app/widgets/elevatedButtonCutom.dart';
import 'package:subscription_app/constants/auth.dart';
import 'package:subscription_app/screens/home_screen.dart';
import 'package:subscription_app/services/notifications.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final formKey = GlobalKey<FormState>();

  final emailRegisterController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();

  void doLoginWithGoogle() async {
    String googleToken = await Authentication.signInWithGoogle();
    dynamic params = {
      'client_id': kClientId,
      'client_secret': kClientSecret,
      'provider': kProviderGoogle,
      'grant_type': kGrantTypeSocial,
      'access_token': googleToken
    };
    final auth = Authentication();
    bool _isLoginOk = await auth.login(params);
    bool _isNotificationOk = await doNotification();

    if (_isLoginOk && _isNotificationOk) {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
  }

  void doLogin() async {
    String email = emailRegisterController.text;
    String password = passwordRegisterController.text;

    if (formKey.currentState.validate()) {
      dynamic params = {
        'username': email,
        'password': password,
        'client_secret': kClientSecret,
        'client_id': kClientId,
        'grant_type': kGrantTypePassword,
      };
      final auth = Authentication();
      bool _isLoginOk = await auth.login(params);
      bool _isNotificationOk = await doNotification();

      if (_isLoginOk && _isNotificationOk) {
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
        'email': email,
        'password': password,
      };
      final auth = Authentication();
      bool isRegOk = await auth.register(params);
      if (isRegOk) {
        doLogin();
      }
    }
  }

  Future<bool> doNotification() async {
    Notifications notify = Notifications();
    String tokenFire = await notify.getTokenFire();
    bool data = await notify.chanelNotification(tokenFire: tokenFire);
    return data;
  }

  @override
  void dispose() {
    emailRegisterController.dispose();
    confirmPasswordController.dispose();
    userNameRegisterController.dispose();
    passwordRegisterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerButtons = Column(
      children: <Widget>[
        SocialButtonCustom(
            textButton: 'REGISTER WITH GOOGLE',
            svgIconPath: 'images/googleicon.svg',
            onPress: () {
              doLoginWithGoogle();
            }),
        SizedBox(
          height: 10,
        ),
        ElevatedButtonCustom(textButton: 'REGISTER', onPress: doRegister)
      ],
    );

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormFieldCustom(
            hintText: kHintTextUserName,
            icon: Icons.account_circle_outlined,
            textController: userNameRegisterController,
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormFieldCustom(
            hintText: kHintTextEmail,
            icon: Icons.email_outlined,
            textController: emailRegisterController,
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormFieldCustom(
            hintText: kHintTextPassword,
            icon: Icons.remove_red_eye_sharp,
            textController: passwordRegisterController,
            obscureText: true,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormFieldCustom(
            hintText: kHintTextConfirmPassword,
            icon: Icons.remove_red_eye_sharp,
            textController: confirmPasswordController,
            obscureText: true,
          ),
          SizedBox(
            height: 15,
          ),
          registerButtons
        ],
      ),
    );
  }
}
