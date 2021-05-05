import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class SubscriptionWidget extends StatefulWidget {
  @override
  _SubscriptionWidgetState createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  Color colorBel = Colors.black;
  IconData iconBel = Icons.notifications_none;
  bool stateBel = false;

  void notification(bool isActive) {
    stateBel = isActive ? false : true;
    setState(() {
      colorBel = stateBel ? Colors.amber[700] : Colors.black;
      iconBel =
          stateBel ? Icons.notifications_active : Icons.notifications_none;
      stateBel = stateBel ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 78,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.21, sigmaY: 8.21),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0x908360c3),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('images/amazon.svg'),
                  SvgPicture.asset('images/netflix.svg'),
/*
                  SvgPicture.asset('images/disney.svg'),
*/
                  Text(
                    '12',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('May'),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      notification(stateBel);
                    },
                    child: Icon(
                      iconBel,
                      size: 30,
                      color: colorBel,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
