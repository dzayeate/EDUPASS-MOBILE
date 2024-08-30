import 'package:edupass_mobile/api/competition/get/get_comp_scheduled_service.dart';
import 'package:edupass_mobile/models/event/event_model.dart';
import 'package:edupass_mobile/screens/calendar_competitions/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart'; // Make sure to adjust this import based on your file structure

class CalendarCompetition extends StatefulWidget {
  const CalendarCompetition({super.key});

  @override
  State<CalendarCompetition> createState() => _CalendarCompetitionState();
}

class _CalendarCompetitionState extends State<CalendarCompetition> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final Map<DateTime, List<EventModel>> _events = {};

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    GetScheduledCompetitionService service = GetScheduledCompetitionService();
    List<EventModel> events = await service.fetchCompetitionEvents();

    setState(() {
      for (var event in events) {
        final eventDate =
            DateTime.utc(event.date.year, event.date.month, event.date.day);
        if (_events[eventDate] == null) {
          _events[eventDate] = [];
        }
        _events[eventDate]!.add(event);
      }
    });
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForDay(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar Events',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 16.0),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "List Events",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          if (events.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  const SizedBox(height: 16.0);
                  return ListTile(
                    title: Text("❁  ${event.title}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailPage(event: event),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          else
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty-box.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Belum Ada Event Hari Ini",
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 48, 48),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
