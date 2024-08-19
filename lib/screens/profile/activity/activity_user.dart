import 'package:edupass_mobile/api/competition/get/get_comp_registration_service.dart';
import 'package:edupass_mobile/controllers/competition/get/get_comp_registration_controller.dart';
import 'package:edupass_mobile/controllers/users/profile_user_controller.dart';
import 'package:edupass_mobile/screens/profile/activity/components/activity_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActivityUser extends StatefulWidget {
  final String userId;
  const ActivityUser({super.key, required this.userId});

  @override
  State<ActivityUser> createState() => _ActivityUserState();
}

class _ActivityUserState extends State<ActivityUser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CompRegistrationController _competitionController =
      CompRegistrationController(FindCompetitionService());

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
    return ChangeNotifierProvider(
      create: (context) => ProfileUserController(),
      child: Scaffold(
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
                    Tab(text: 'Submission'),
                    Tab(text: 'Riwayat Aktivitas'),
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
                  children: [
                    SubmissionTab(
                      competitionController: _competitionController,
                      userId: widget.userId, // Gunakan userId yang diteruskan
                    ),
                    const HistoryTab(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
