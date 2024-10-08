import 'package:edupass_mobile/models/event/event_model.dart';
import 'package:edupass_mobile/screens/home/detail_comp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;
  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white),
                      const SizedBox(width: 8.0),
                      Text(
                        'Selasa, ${event.date.day} Juni',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.timelapse, color: Colors.white),
                      const SizedBox(width: 8.0),
                      Text(
                        'Jam: ${event.time}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              '❁ Penjelasan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(child: Text(event.description)),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              '❁ Nama Kompetisi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(event.competitionName),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              '❁ Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(event.location),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              '❁ Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(event.category),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailCompScreen(id: event.competitionId),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Menuju ke Detail Lomba',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
