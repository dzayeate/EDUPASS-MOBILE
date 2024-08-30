import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:edupass_mobile/models/event/comp_registration_model.dart';
import 'package:edupass_mobile/utils/constant.dart';

class FindCompetitionService {
  final Dio _dio;

  FindCompetitionService() : _dio = Dio() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<List<CompetitionRegistration>> fetchRegistrations(
      String userId) async {
    try {
      final response = await _dio.get(
        '${baseUrl}competition/findCompetitionRegistration',
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
