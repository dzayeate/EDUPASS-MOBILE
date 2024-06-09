import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Ionicons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.calendar),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.cart_sharp),
          label: 'Scan QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.person),
          label: 'Profile',
        ),
      ],
      unselectedItemColor: Colors.black, // Set color for unselected icons
      selectedItemColor: Colors.black, // Set color for selected icons
      onTap: (index) {
        // Handle navigation based on index
      },
    );
  }
}
