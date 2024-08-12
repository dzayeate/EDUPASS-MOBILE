import 'package:edupass_mobile/screens/profile/activity/components/activity_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityUser extends StatefulWidget {
  const ActivityUser({super.key});

  @override
  State<ActivityUser> createState() => _ActivityUserState();
}

class _ActivityUserState extends State<ActivityUser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Activity',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(text: 'Aktivitas Dimulai'),
                  Tab(text: 'Aktivitas Selesai'),
                ],
                indicator: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(30),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  UnfinishTab(),
                  FinishTab(),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
