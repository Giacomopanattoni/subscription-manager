import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SpinKitFadingCube(
        color: Colors.purpleAccent,
        size: 80.0,
      ),
    );
  }
}
