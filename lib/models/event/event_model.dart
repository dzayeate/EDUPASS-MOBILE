import 'package:intl/intl.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String competitionName;
  final String competitionId;
  final String category;
  final String location;
  final String time;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.competitionName,
    required this.competitionId,
    required this.category,
    required this.location,
    required this.time,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    // Parsing the time field
    final parsedTime = DateFormat('HH:mm:ss').parse(json['time']);
    final formattedTime = DateFormat('HH:mm').format(parsedTime);

    return EventModel(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      competitionName: json['competition']['name'],
      category: json['category'],
      competitionId: json['competition']['id'],
      location: json['location'],
      time: formattedTime,
    );
  }
}
