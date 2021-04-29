import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String textButton;
  final VoidCallback onPress;

  const ElevatedButtonCustom(
      {@required this.textButton, @required this.onPress})
      : assert(textButton != null),
        assert(onPress != null);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Ink(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff9b23ea), Color(0xff391792)]),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 350,
          height: 45,
          alignment: Alignment.center,
          child: Text(
            textButton,
          ),
        ),
      ),
    );
  }
}
