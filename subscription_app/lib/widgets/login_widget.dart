import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_app/services/app_state.dart';
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
      bool logged = await Provider.of<AppState>(context, listen: false)
          .login(email, password);
      if (!logged) await _showMyDialog();
    }
  }

  void doLoginWithGoogle() async {
    String googleToken = await Authentication.signInWithGoogle();
    bool logged = await Provider.of<AppState>(context, listen: false)
        .googleLogin(googleToken);
    if (!logged) await _showMyDialog();
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
          loginButtons,
        ],
      ),
    );
  }
}
