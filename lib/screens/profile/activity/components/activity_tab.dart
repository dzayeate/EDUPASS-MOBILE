import 'package:edupass_mobile/screens/competition_task/comp_task/comp_submit_task.dart';
import 'package:edupass_mobile/screens/profile/activity/components/activity_card.dart';
import 'package:edupass_mobile/screens/profile/activity/components/activity_empty.dart';
import 'package:flutter/material.dart';

class UnfinishTab extends StatelessWidget {
  const UnfinishTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ActivityCard(
          title: 'Terdaftar',
          buttonText: 'Kumpulkan',
          onPressed: () {
            // Handle button press
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SubmitCompetitionTask()),
            );
          },
        ),
      ),
    );
  }
}

// class UnfinishTab extends StatelessWidget {
//   const UnfinishTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const ActivityEmpty();
//   }
// }

class FinishTab extends StatelessWidget {
  const FinishTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const ActivityEmpty();
  }
}
