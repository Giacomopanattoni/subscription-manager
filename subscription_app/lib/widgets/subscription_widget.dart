import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:subscription_app/models/subscription_model.dart';
import 'package:subscription_app/services/app_data.dart';

class SubscriptionWidget extends StatefulWidget {
  @override
  SubscriptionWidget({this.subscription});
  final Subscription subscription;
  _SubscriptionWidgetState createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  Color colorBel = Colors.black;
  IconData iconBel = Icons.notifications_none;
  bool stateBel = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.21, sigmaY: 8.21),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(int.parse(widget.subscription.color)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.subscription.getImage(),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.subscription.nextRenewal.day.toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.subscription.nextRenewal.month
                                .toString()),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<AppData>(context, listen: false)
                                .changeNotify(widget.subscription);
                          },
                          child: Icon(
                            widget.subscription.notify
                                ? Icons.notifications_active
                                : Icons.notifications_none,
                            size: 30,
                            color: widget.subscription.notify
                                ? Colors.amber[700]
                                : Colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
