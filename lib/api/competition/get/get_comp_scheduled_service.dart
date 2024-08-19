import 'package:dio/dio.dart';
import 'package:edupass_mobile/models/event/event_model.dart';

class GetScheduledCompetitionService {
// Get All Competition ( Pagination )
  Future<List<EventModel>> fetchCompetitionEvents() async {
    try {
      final response = await Dio().get(
        'http://103.141.61.6/competition/findScheduleCompetition',
        queryParameters: {
          'page': 1,
          'length': 10,
        },
        options: Options(
          headers: {
            'accept': 'application/json',
          },
        ),
      );

      List<EventModel> events = (response.data['data'] as List)
          .map((event) => EventModel.fromJson(event))
          .toList();

      return events;
    } catch (e) {
      print('Error fetching competition events: $e');
      return [];
    }
  }
}
