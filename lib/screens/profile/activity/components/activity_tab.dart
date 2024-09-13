import 'package:edupass_mobile/controllers/competition/get/get_comp_registration_controller.dart';
import 'package:edupass_mobile/controllers/users/profile_user_controller.dart';
import 'package:edupass_mobile/models/event/comp_registration_model.dart';
import 'package:edupass_mobile/screens/competition_task/comp_task/comp_submit_task.dart';
import 'package:edupass_mobile/screens/home/detail_comp.dart';
import 'package:edupass_mobile/screens/profile/activity/components/activity_card.dart';
import 'package:edupass_mobile/screens/profile/activity/components/activity_empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmissionTab extends StatefulWidget {
  final CompRegistrationController competitionController;
  final String userId;

  const SubmissionTab({
    super.key,
    required this.competitionController,
    required this.userId,
  });

  @override
  State<SubmissionTab> createState() => _SubmissionTabState();
}

class _SubmissionTabState extends State<SubmissionTab> {
  late Future<List<CompetitionRegistration>> _registrationsFuture;

  @override
  void initState() {
    super.initState();
    _registrationsFuture =
        widget.competitionController.getRegistrations(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompetitionRegistration>>(
      future: _registrationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const ActivityEmpty();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final registration = snapshot.data![index];
              return SubmissionActivityCard(
                competitionName: registration.competitionName,
                subtitle: registration.domicile,
                date: registration.createdAt
                    .toLocal()
                    .toString()
                    .substring(0, 10),
                isTeam: registration.isTeam,
                phoneNumber: 'Nomor HP : ${registration.phoneNumber}',
                teamSize: registration.teamSize,
                firstButtonLabel: 'Detail Competisi',
                secondButtonLabel: 'Kumpulkan Tugas',
                onFirstButtonPressed: () {
                  // Handle first button action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailCompScreen(
                              id: registration.competitionId,
                            )),
                  );
                },
                onSecondButtonPressed: () {
                  // Handle second button action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubmitCompetitionTask(
                              registrationId: registration.id,
                            )),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileUserController>(
      builder: (context, profileController, child) {
        if (profileController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (profileController.userData == null) {
          return const Center(child: Text('No data available'));
        } else {
          final activities = profileController.getUserActivities();

          if (activities.isEmpty) {
            return const ActivityEmpty();
          } else {
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return HistoryActivityCard(
                  title: activity.competitionName,
                  subtitle: 'Status: ${activity.status}',
                  date: activity.competitionStartDate,
                );
              },
            );
          }
        }
      },
    );
  }
}
