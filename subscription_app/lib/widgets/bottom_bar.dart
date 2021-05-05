import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  BottomBar({this.currentIndex, this.onChange});

  final currentIndex;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomNavigationBar(
        iconSize: 25.0,
        selectedColor: Colors.black,
        strokeColor: Colors.black,
        unSelectedColor: Colors.black,
        backgroundColor: Colors.white,
        borderRadius: Radius.circular(20.0),
        isFloating: true,
        elevation: 8.0,
        currentIndex: currentIndex,
        onTap: (index) {
          onChange(index);
        },
        items: [
          CustomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
