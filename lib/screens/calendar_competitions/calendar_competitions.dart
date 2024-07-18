import 'package:edupass_mobile/api/competition/get/scheduled/get_scheduled_comp_service.dart';
import 'package:edupass_mobile/models/event/event_model.dart';
import 'package:edupass_mobile/screens/calendar_competitions/event_detail_page.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/utils/event_card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Make sure to adjust this import based on your file structure

class CalendarCompetition extends StatefulWidget {
  const CalendarCompetition({super.key});

  @override
  _CalendarCompetitionState createState() => _CalendarCompetitionState();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App'),
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
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDay).length,
              itemBuilder: (context, index) {
                final event = _getEventsForDay(_selectedDay)[index];
                return ListTile(
                  title: Text(event.title),
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
          ),
        ],
      ),
    );
  }
}
