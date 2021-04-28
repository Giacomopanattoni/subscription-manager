import 'package:flutter/material.dart';
import 'package:subscription_app/constants/style.dart';

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.obscureText,
        controller: widget.textController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ' + widget.hintText.toLowerCase();
          } else {
            if (widget.hintText == 'Email address' && !value.contains('@')) {
              return 'Please enter a valid ' + widget.hintText.toLowerCase();
            }
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: kTextFieldDecoration(
            hintText: widget.hintText, prefixIcon: widget.icon),
        onChanged: (value) {
          textValue = value;
        });
  }
}
