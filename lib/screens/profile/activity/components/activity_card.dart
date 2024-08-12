import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const ActivityCard({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
