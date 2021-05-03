import 'package:flutter/material.dart';
import 'package:subscription_app/constants/style.dart';
import 'package:subscription_app/constants/auth.dart';

class TextFormFieldCustom extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController textController;

  const TextFormFieldCustom(
      {@required this.hintText,
      @required this.icon,
      @required this.textController,
      @required this.obscureText})
      : assert(hintText != null),
        assert(icon != null),
        assert(textController != null),
        assert(obscureText != null);

  @override
  _TextFormFieldCustomState createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  String textValue;
  String _valuePassword;

  String validation(String value) {

    if (value == null || value.isEmpty) {
      return 'Please enter your ' + widget.hintText.toLowerCase();
    }
    switch (widget.hintText) {
      case kHintTextEmail:
        RegExp regexEmail = RegExp(kPatternEmail);
        if (!regexEmail.hasMatch(value)) {
          return 'Please enter a valid ' + widget.hintText.toLowerCase();
        }
        return null;
        break;
      case kHintTextPassword:
        _valuePassword = value;
        if (value.length < 6) {
          return 'The password must be at least 6 characters';
        }
        return null;
        break;
      case kHintTextConfirmPassword:
        if (_valuePassword != value) {
          return 'The password and confirmation password do not match';
        }
        return null;
        break;
      default:
        return null;
        break;
    }
  }

  TextInputType textInputType() {
    switch (widget.hintText) {
      case kHintTextPassword:
        return TextInputType.visiblePassword;
        break;
      case kHintTextEmail:
        return TextInputType.emailAddress;
        break;
      case kHintTextUserName:
        return TextInputType.name;
        break;
      default:
        return TextInputType.text;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.obscureText,
        controller: widget.textController,
        validator: validation,
        keyboardType: textInputType(),
        decoration: kTextFieldDecoration(
            hintText: widget.hintText, prefixIcon: widget.icon),
        onChanged: (value) {
          textValue = value;
        });
  }
}
