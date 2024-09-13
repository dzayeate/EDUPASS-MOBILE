import 'package:flutter/material.dart';

// Activity Card for Submission Tab
class SubmissionActivityCard extends StatelessWidget {
  final String competitionName;
  final String subtitle;
  final String date;
  final bool isTeam;
  final int? teamSize;
  final String phoneNumber;
  final VoidCallback onFirstButtonPressed;
  final VoidCallback onSecondButtonPressed;
  final String firstButtonLabel;
  final String secondButtonLabel;

  const SubmissionActivityCard({
    super.key,
    required this.competitionName,
    required this.subtitle,
    required this.date,
    required this.isTeam,
    required this.phoneNumber,
    this.teamSize,
    required this.onFirstButtonPressed,
    required this.onSecondButtonPressed,
    required this.firstButtonLabel,
    required this.secondButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Competition: $competitionName',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              phoneNumber,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'domisili : $subtitle',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Tanggal : $date',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            if (isTeam) ...[
              const SizedBox(height: 8),
              Text(
                'Team Registration (Size: ${teamSize ?? 'N/A'})',
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onFirstButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.indigo, // Warna background button pertama
                  ),
                  child: Text(
                    firstButtonLabel,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: onSecondButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange, // Warna background button pertama
                  ),
                  child: Text(
                    secondButtonLabel,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Activity Card for History Tab
class HistoryActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;

  const HistoryActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
