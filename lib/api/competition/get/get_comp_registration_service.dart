import 'package:dio/dio.dart';
import 'package:edupass_mobile/models/event/comp_registration_model.dart';

class FindCompetitionService {
  final Dio _dio = Dio();

  Future<List<CompetitionRegistration>> fetchRegistrations(
      String userId) async {
    try {
      final response = await _dio.get(
        'http://192.168.1.4:3000/competition/findCompetitionRegistration',
        queryParameters: {
          'page': 1,
          'length': 10,
          'search': userId,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data
            .map((json) => CompetitionRegistration.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load registrations');
      }
    } catch (e) {
      throw Exception('Error fetching registrations: $e');
    }
  }
}
