import 'package:edupass_mobile/navigation/bottom_nav_bar.dart';
import 'package:edupass_mobile/screens/calendar_competitions/calendar_competitions.dart';
import 'package:edupass_mobile/screens/home/home_screen.dart';
import 'package:edupass_mobile/screens/list_competitions/list_competitions.dart';
import 'package:edupass_mobile/screens/profile/profile_user.dart';
import 'package:edupass_mobile/screens/scan_qr/scan_qr_screen.dart';
import 'package:flutter/material.dart';

class EduPassApp extends StatefulWidget {
  final int initialPageIndex;

  const EduPassApp({super.key, this.initialPageIndex = 0});
  static final GlobalKey<_EduPassAppState> globalKey =
      GlobalKey<_EduPassAppState>();

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
    const CalendarCompetition(),
    const ProfileUser(),
  ];

  void updatePageIndex(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _pageIndex,
        onTap: (index) {
          updatePageIndex(index);
        },
      ),
      body: _pages[_pageIndex],
    );
  }
}
