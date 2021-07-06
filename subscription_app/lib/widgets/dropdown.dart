import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  Dropdown({this.value, this.values, this.onChange, this.text});
  final Function onChange;
  final List<String> values;
  final String value;
  final String text;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      focusColor: Colors.white,
      value: value,
      elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        onChange(value);
      },
    );
  }
}
