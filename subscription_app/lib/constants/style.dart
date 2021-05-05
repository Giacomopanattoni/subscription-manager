import 'package:flutter/material.dart';

const kTextColorLight = Colors.grey;
const kTextColorDark = Colors.black;
const kColorPrimary = Colors.purple;
const kColorError = Colors.red;

const kMainBackground = Color(0xFFEFEFEF);
const kSecondaryColor = Color(0xFF9B23EA);

kTextFieldDecoration({IconData prefixIcon, String hintText}) {
  return InputDecoration(
    hintText: hintText,
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(1),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: kColorPrimary,
      ),
    ),
    prefixIcon: Icon(
      prefixIcon,
      color: kTextColorLight,
    ),
  );
}
