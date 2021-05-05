import 'package:flutter/material.dart';
import 'package:subscription_app/widgets/textFormFieldCustom.dart';
import 'package:subscription_app/widgets/socialButtonCustom.dart';
import 'package:subscription_app/widgets/elevatedButtonCutom.dart';
import 'package:subscription_app/services/authentication.dart';
import 'package:subscription_app/screens/home_screen.dart';
import 'package:subscription_app/constants/auth.dart';
import 'package:subscription_app/services/notifications.dart';
import 'package:subscription_app/constants/style.dart';

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
      bool _isLoginOk = await auth.login(params);
      if (!_isLoginOk) {
        await _showMyDialog();
        return;
      }
      bool _isNotificationOk = await doNotification();
      if (_isLoginOk && _isNotificationOk) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    }
  }

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

  Future<bool> doNotification() async {
    Notifications notify = Notifications();
    String tokenFire = await notify.getTokenFire();
    bool data = await notify.chanelNotification(tokenFire: tokenFire);
    return data;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.error,
            color: kColorError,
            size: 70,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Opss..'),
                Text('Please check your credentials and try again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: kTextColorDark)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            hintText: kHintTextEmail,
            icon: Icons.email_outlined,
            textController: emailLoginController,
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormFieldCustom(
            hintText: kHintTextPassword,
            icon: Icons.remove_red_eye_sharp,
            textController: passwordLoginController,
            obscureText: true,
          ),
          SizedBox(
            height: 15,
          ),
          loginButtons
        ],
      ),
    );
  }
}
