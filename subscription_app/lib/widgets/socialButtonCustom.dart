import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subscription_app/constants/style.dart';

class SocialButtonCustom extends StatelessWidget {
  final String textButton;
  final String svgIconPath;
  final VoidCallback onPress;

  const SocialButtonCustom(
      {@required this.textButton,
      @required this.svgIconPath,
      @required this.onPress})
      : assert(textButton != null),
        assert(svgIconPath != null),
        assert(onPress != null);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Container(
        width: 350,
        height: 45,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SvgPicture.asset(
              svgIconPath,
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              textButton,
              style: TextStyle(
                color: kTextColorLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
