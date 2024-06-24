import 'package:edupass_mobile/navigations/bottom_nav_bar.dart';
import 'package:edupass_mobile/screens/calendar_competitions/calendar_competitions.dart';
import 'package:edupass_mobile/screens/home/home_screen.dart';
import 'package:edupass_mobile/screens/list_competitions/list_competitions.dart';
import 'package:edupass_mobile/screens/profile/components/profile_text_field.dart';
import 'package:edupass_mobile/screens/profile/education/education_screen.dart';
import 'package:edupass_mobile/screens/profile/profile_user.dart';
import 'package:edupass_mobile/screens/profile/profile_user_detail.dart';
import 'package:edupass_mobile/screens/profile/settings/setting_screen.dart';
import 'package:edupass_mobile/screens/scan_qr/scan_qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class EduPassApp extends StatefulWidget {
  final int initialPageIndex;

  const EduPassApp({super.key, this.initialPageIndex = 0});

  @override
  State<EduPassApp> createState() => _EduPassAppState();
}

class _EduPassAppState extends State<EduPassApp> {
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.initialPageIndex;
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const ListCompetitions(),
    const ScanQrCode(),
    CalendarCompetition(),
    const ProfileUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _pageIndex == 2
          ? null
          : BottomNavBar(
              currentIndex: _pageIndex,
              onTap: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
            ),
      body: _pages[_pageIndex],
    );
  }
}
