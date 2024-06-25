import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 70.0,
      backgroundColor: Colors.transparent,
      color: Colors.indigo,
      animationDuration: Duration(milliseconds: 500),
      index: currentIndex,
      onTap: onTap,
      items: const <Widget>[
        Icon(
          Icons.home,
          color: Colors.white,
        ),
        Icon(
          Icons.assignment,
          color: Colors.white,
        ),
        Icon(
          Icons.qr_code_2,
          color: Colors.white,
        ),
        Icon(
          Icons.calendar_month,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          color: Colors.white,
        ),
      ],
    );
  }
}
