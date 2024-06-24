import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/utils/event_card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Make sure to adjust this import based on your file structure

class CalendarCompetition extends StatefulWidget {
  @override
  _CalendarCompetitionState createState() => _CalendarCompetitionState();
}

class _CalendarCompetitionState extends State<CalendarCompetition> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EduPassApp(initialPageIndex: 1),
              ),
            );
          },
        ),
        title: Text(
          'Calendar Competitions',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: ListView(
                children: const [
                  EventCard(
                    title: 'NSPACE 2024 : UI/UX COMPETITION',
                    date: '11 Juli 2024',
                    location: 'Kampus FT',
                    peopleRegistered: '50 Orang Terdaftar',
                    label: 'Lomba',
                    label2: 'UI/UX Design',
                    imageUrl:
                        'assets/images/competition_1.png', // Adjust image asset
                  ),
                  EventCard(
                    title: 'NSPACE 2024 : Web COMPETITION',
                    date: '11 Juli 2024',
                    location: 'Silicon Valley',
                    peopleRegistered: '50 Orang Terdaftar',
                    label: 'Lomba',
                    label2: 'UI/UX Design',
                    imageUrl:
                        'assets/images/competition_2.png', // Adjust image asset
                  ),
                  EventCard(
                    title: 'MObil lejen',
                    date: '11 Juli 2024',
                    location: 'Di rumah',
                    peopleRegistered: '50 Orang Terdaftar',
                    label: 'Lomba',
                    label2: 'E-sport',
                    imageUrl:
                        'assets/images/competition_2.png', // Adjust image asset
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
