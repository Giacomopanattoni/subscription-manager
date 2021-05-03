import 'package:flutter/material.dart';

const kTextColorLight = Colors.grey;
const kTextColorDark = Colors.black;
const kColorPrimary = Colors.purple;
const kColorError = Colors.red;

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
